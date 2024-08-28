import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:giveup/Controller/App_controller.dart';
import 'package:giveup/components/Activity_tile_today_component.dart';
import 'package:giveup/components/Bottom_sheet_content_today_component.dart';
import 'package:giveup/components/Calendar_display_ibadah_component.dart';
import 'package:giveup/components/Date_display_ibadah_component.dart';
import 'package:giveup/components/Section_title_today_component.dart';
import 'package:giveup/screens/ActivityWidget.dart';
import 'package:giveup/screens/SelectableButtonActivity.dart';
import 'package:intl/intl.dart';
import 'package:uid/uid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AppControler app = Get.find();
  DateTime _selectedDay = DateTime.now();
  final String defaultImagePath = 'lib/assets/icons/childMasjid.png';
  List<Map<String, dynamic>> userActivities = [];
  bool _isActivityWidgetVisible = false;
  final Map<String, dynamic> _selectedActivity = {};

  @override
  void initState() {
    super.initState();
    app.loadListUserActivities();
    app.loadUserActivityLogs();
    app.fetchPrayerTimes();
    userActivities = app.userActivities;
  }

  void _onSelectedDate(DateTime selectedDate) {
    setState(() {
      _selectedDay = selectedDate;
    });
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const BottomSheetContentTodayComponent(),
    );
  }

  bool _isEditable(DateTime date, Map<String, dynamic> activity) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(date);
    final String today = formatter.format(DateTime.now());
    if (activity['category']['name'] == "Sholat") {
      return true;
    }
    return formattedDate.compareTo(today) <= 0;
  }

  void _validateAndCheck(bool? newValue, Map<String, dynamic> activity) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final String selectedDate = dateFormat.format(_selectedDay);
    final String todayDate = dateFormat.format(DateTime.now());

    if (selectedDate == todayDate &&
        activity['category']['name'] == "Sholat Wajib") {
      final DateFormat timeFormat = DateFormat('HH:mm');
      final DateTime now = DateTime.now();
      final String currentTime = timeFormat.format(now);
      final String activityTime = activity['des'];

      if (currentTime.compareTo(activityTime) < 0) {
        Fluttertoast.showToast(
          msg: "Belum waktunya ${activity['name']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return;
      }
    }

    if (newValue ?? false) {
      if (!app.userActivityLogs
          .any((log) => log['activity_id'] == activity['id'])) {
        app.addUserActivityLog({
          'id': UId.getId(),
          'activity_id': activity['id'],
          'completed_at': _selectedDay,
        });
        Fluttertoast.showToast(
          msg: "${activity['name']} berhasil dicentang",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } else {
      app.removeUserActivityLog(activity['id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DateDisplayIbadahComponent(
                    selectedDay: _selectedDay,
                    hijriMonthsIndonesia: app.hijriMonthsIndonesia,
                    daysOfWeekIndonesia: app.daysOfWeekIndonesia,
                  ),
                  const SizedBox(height: 5),
                  CalendarDisplayIbadahComponent(
                    selectedDay: _selectedDay,
                    onDateSelected: _onSelectedDate,
                    events: const {},
                  ),
                  const SizedBox(width: 45),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SelectableButtonActivity(
                          text: "All",
                          onTap: () {
                            setState(() {
                              _isActivityWidgetVisible = false;
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        SelectableButtonActivity(
                          text: "New Activity",
                          icon: Icons.format_list_bulleted_add,
                          onTap: _showBottomSheet,
                          isSpecialButton: true,
                        ),
                        const SizedBox(width: 10),
                        Obx(
                          () {
                            return Row(
                              children: app.newListActivities.map((activity) {
                                final activityName = activity['activity']
                                        ['name'] ??
                                    'Unnamed Activity';
                                final iconCode = activity['activity']['icon'];
                                final selectedOption = activity['activity']
                                        ['option'] ??
                                    'No Option';

                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: SelectableButtonActivity(
                                    text: activityName,
                                    icon: iconCode != null
                                        ? IconData(iconCode,
                                            fontFamily: 'MaterialIcons')
                                        : Icons.error,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ActivityWidget(
                                            listName: activityName,
                                            selectedIcon: iconCode != null
                                                ? IconData(iconCode,
                                                    fontFamily: 'MaterialIcons')
                                                : Icons.error,
                                            selectedOption: selectedOption,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Visibility(
                    visible: _isActivityWidgetVisible,
                    child: ActivityWidget(
                      listName: _selectedActivity['name'] ?? 'No Name',
                      selectedIcon: _selectedActivity['icon'] != null
                          ? IconData(_selectedActivity['icon'],
                              fontFamily: 'MaterialIcons')
                          : Icons.error,
                      selectedOption:
                          _selectedActivity['option'] ?? 'No Option',
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      final bool isHaidMode = app.haidMode.value;
                      final activityLogsForSelectedDate =
                          app.getActivityLogsForDate(_selectedDay) ?? [];
                      final userActivities = app.userActivities ?? [];

                      final completedActivities = activityLogsForSelectedDate
                          .where((log) => log['completed_at'] != null)
                          .toList();
                      final incompletedActivities =
                          userActivities.where((element) {
                        final activity =
                            element['activity'] as Map<String, dynamic>?;
                        if (activity == null) return false;

                        if (isHaidMode) {
                          if (activity['name'] == "Zikir Pagi" ||
                              activity['name'] == "Zikir Sore") {
                            return !activityLogsForSelectedDate.any(
                                (log) => log['activity_id'] == activity['id']);
                          } else {
                            return false;
                          }
                        }

                        return !activityLogsForSelectedDate
                            .any((log) => log['activity_id'] == activity['id']);
                      }).toList();

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (incompletedActivities.isNotEmpty)
                              const SectionTitleTodayComponent(
                                  title: "Belum Tercapai"),
                            ...incompletedActivities.map((element) {
                              final activity =
                                  element['activity'] as Map<String, dynamic>?;
                              final iconPath =
                                  app.getIcon(activity?['name'] ?? '');

                              return ActivityTileTodayComponent(
                                activity: {
                                  ...activity ?? {},
                                  'imagePath': iconPath,
                                },
                                isCompleted: false,
                                isBloked:
                                    _isEditable(_selectedDay, activity ?? {}),
                                selectedDay: _selectedDay,
                                onChanged: (newValue) =>
                                    _validateAndCheck(newValue, activity ?? {}),
                              );
                            }),
                            if (completedActivities.isNotEmpty)
                              const SectionTitleTodayComponent(
                                  title: "Telah Tercapai"),
                            ...completedActivities.map((log) {
                              final activity = userActivities.firstWhere(
                                (element) =>
                                    element['activity']['id'] ==
                                    log['activity_id'],
                                orElse: () => {'activity': {}},
                              )['activity'] as Map<String, dynamic>?;

                              final iconPath =
                                  app.getIcon(activity?['name'] ?? '');

                              return ActivityTileTodayComponent(
                                activity: {
                                  ...activity ?? {},
                                  'imagePath': iconPath,
                                },
                                isCompleted: true,
                                isBloked:
                                    _isEditable(_selectedDay, activity ?? {}),
                                selectedDay: _selectedDay,
                                onChanged: (newValue) =>
                                    _validateAndCheck(newValue, activity ?? {}),
                              );
                            }),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      _showBottomSheet();
                    },
                    child: const Icon(Icons.chat_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
