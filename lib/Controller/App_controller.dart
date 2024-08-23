import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppControler extends GetxController {
  final initialTabIndex = 0.obs;
  final activeTab = 0.obs;
  final haidMode = false.obs;
  final safarMode = false.obs;
  final repeatText = ''.obs;
  final selectedIcon = ''.obs;

  var newListActivities = <Map<String, dynamic>>[].obs;

  // Fungsi untuk menambahkan aktivitas ke dalam list dan menyimpannya ke SharedPreferences
  void addListUserActivity(
      String listName, IconData selectedIcon, String selectedOption) async {
    newListActivities.add({
      'activity': {
        'name': listName,
        'icon': selectedIcon.codePoint,
      },
      'option': selectedOption,
    });
    await saveListUserActivities(); // Save after adding the activity
    update();
  }

// Fungsi untuk menyimpan list aktivitas ke SharedPreferences
  Future<void> saveListUserActivities() async {
    final prefs = await SharedPreferences.getInstance();
    final activities = newListActivities
        .map((activity) => {
              'name': activity['activity']['name'],
              'icon': activity['activity']['icon'],
              'option': activity['option'],
            })
        .toList();
    await prefs.setString('listActivities', jsonEncode(activities));
  }

// Fungsi untuk memuat list aktivitas dari SharedPreferences
  Future<void> loadListUserActivities() async {
    final prefs = await SharedPreferences.getInstance();
    final activitiesString = prefs.getString('listActivities');
    if (activitiesString != null) {
      final List<dynamic> decodedList = jsonDecode(activitiesString);
      final List<Map<String, dynamic>> activities = decodedList
          .map((item) => {
                'activity': {
                  'name': item['name'],
                  'icon': item['icon'],
                },
                'option': item['option'],
              })
          .toList();
      newListActivities.assignAll(activities);
    }
  }

  final Map<String, List<Map<String, String>>> ibadahItems = {
    'Sholat': [
      {'text': 'Magrib', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Isya', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Salat Tahajud', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Subuh', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Salat Duha', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Jumat', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Zuhur', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Asar', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Salat Tarawih', 'imagePath': 'lib/assets/icons/mosque.png'},
    ],
    'Puasa': [
      {'text': 'Puasa Ramadhan', 'imagePath': 'lib/assets/icons/no-food.png'},
      {'text': 'Puasa Syawal', 'imagePath': 'lib/assets/icons/no-food.png'},
      {'text': 'Puasa Dzulhijjah', 'imagePath': 'lib/assets/icons/no-food.png'},
      {'text': 'Puasa Arafah', 'imagePath': 'lib/assets/icons/no-food.png'},
      {'text': 'Puasa Tasua', 'imagePath': 'lib/assets/icons/no-food.png'},
      {'text': 'Puasa Senin', 'imagePath': 'lib/assets/icons/no-food.png'},
      {'text': 'Puasa Kamis', 'imagePath': 'lib/assets/icons/no-food.png'},
      {'text': 'Ayyamul Bidh', 'imagePath': 'lib/assets/icons/no-food.png'},
    ],
    'Al-Quran & Hadist': [
      {'text': 'Baca AlQuran', 'imagePath': 'lib/assets/icons/alQuran.png'},
      {
        'text': 'Baca Surah Alkahfi',
        'imagePath': 'lib/assets/icons/alQuran.png'
      },
    ],
    'Sedekah & Zakat': [
      {'text': 'Zakat Fitrah', 'imagePath': 'lib/assets/icons/zakat.png'},
      {'text': 'Sedekah Subuh', 'imagePath': 'lib/assets/icons/zakat.png'},
      {'text': 'Zakat Mal', 'imagePath': 'lib/assets/icons/zakat.png'},
      {'text': 'Sedekah Jumat', 'imagePath': 'lib/assets/icons/zakat.png'},
    ],
    'Zikir': [
      {'text': 'Zikir Pagi', 'imagePath': 'lib/assets/icons/zikir.png'},
      {'text': 'Zikir Sore', 'imagePath': 'lib/assets/icons/zikir.png'},
    ],
  };

  void setRepeatText(String element) {
    if (element == 'Jumat') {
      repeatText.value = 'Seminggu sekali';
    } else if (element == 'Zikir Pagi') {
      repeatText.value = 'Setiap Pagi';
    } else if (element == 'Zikir Sore') {
      repeatText.value = 'Setiap Sore';
    } else if (element == 'Salat Tarawih') {
      repeatText.value = 'Hanya Pada Malam Puasa Ramadhan';
    } else {
      repeatText.value = 'Setiap Hari';
    }
  }

  RxMap<String, String> icons = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadIcons();
  }

  final List<String> iconsList = [
    'lib/assets/icons/childMasjid.png',
    'lib/assets/icons/church.png',
    'lib/assets/icons/bigMasjid.png',
    'lib/assets/icons/borobudur.png',
    'lib/assets/icons/istanaMasjid.png',
    'lib/assets/icons/masjid.png',
    'lib/assets/icons/buddha.png',
  ];

  final Map<String, String> iconDescriptions = {
    'lib/assets/icons/childMasjid.png': 'Kubah Masjid',
    'lib/assets/icons/church.png': 'Gereja',
    'lib/assets/icons/bigMasjid.png': 'Masjid Besar',
    'lib/assets/icons/borobudur.png': 'Borobudur',
    'lib/assets/icons/istanaMasjid.png': 'Istana Masjid',
    'lib/assets/icons/masjid.png': 'Masjid',
    'lib/assets/icons/buddha.png': 'Buddha',
  };

  void saveSelectedIcon(String iconName) async {
    selectedIcon.value = iconName;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedIcon', iconName);
  }

  void loadSelectedIcon() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? iconName = prefs.getString('selectedIcon');
    if (iconName != null) {
      selectedIcon.value = iconName;
    }
  }

  Future<void> _loadIcons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    icons.clear();

    for (var key in prefs.getKeys()) {
      final value = prefs.get(key);
      if (value is String) {
        final iconPath = value;
        if (iconsList.contains(iconPath)) {
          icons[key] = iconPath;
        }
      }
    }
  }

  Future<void> updateIcon(String item, String iconPath) async {
    if (iconsList.contains(iconPath)) {
      icons[item] = iconPath;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(item, iconPath);
      update();
    }
  }

  String getIcon(String item) {
    return icons[item] ?? 'lib/assets/icons/bigMasjid.png';
  }

  void updateIbadahStatus(String category, String item, bool status) async {}

  bool getIbadahStatus(String category, String item) {
    return false;
  }

  void toggleModeHaid(bool value) {
    haidMode.value = value;
  }

  void toggleModsafar(bool value) {
    safarMode.value = value;
  }

  final activity = [
    {
      "id": 1,
      "name": 'Sholat Magrib',
      "icon": 'lib/assets/icons/mosque.png',
      "des": "17.57",
      "category": {
        "id": 1,
        "name": 'Sholat Wajib',
      },
    },
    {
      "id": 2,
      "name": 'Sholat Isya',
      "icon": 'lib/assets/icons/mosque.png',
      "des": "19.06",
      "category": {
        "id": 1,
        "name": 'Sholat Wajib',
      },
    },
    {
      "id": 3,
      "name": 'Sholat Subuh',
      "icon": 'lib/assets/icons/mosque.png',
      "des": "04.08",
      "category": {
        "id": 1,
        "name": 'Sholat Wajib',
      },
    },
    {
      "id": 4,
      "name": 'Sholat Dhuhur',
      "icon": 'lib/assets/icons/mosque.png',
      "des": "11.45",
      "category": {
        "id": 1,
        "name": 'Sholat Wajib',
      },
    },
    {
      "id": 5,
      "name": 'Sholat Asar',
      "icon": 'lib/assets/icons/mosque.png',
      "des": "15.13",
      "category": {
        "id": 1,
        "name": 'Sholat Wajib',
      },
    },
    {
      "id": 6,
      "name": "Sholat Jum'at",
      "icon": 'lib/assets/icons/mosque.png',
      "des": "12.06",
      "category": {
        "id": 1,
        "name": 'Sholat Wajib',
      },
    },
    {
      "id": 7,
      "name": 'Sholat Tarawih',
      "icon": 'lib/assets/icons/mosque.png',
      "des": "19.30",
      "category": {
        "id": 1,
        "name": 'Sholat Wajib',
      },
    },
    {
      "id": 8,
      "name": 'Sholat Dhuha',
      "icon": 'lib/assets/icons/mosque.png',
      "des": "08.00",
      "category": {
        "id": 1,
        "name": 'Sholat Wajib',
      },
    },
    {
      "id": 9,
      "name": 'Puasa Ramadhan',
      "icon": 'lib/assets/icons/no-food.png',
      "des": "Umat Islam puasa ramadhan 1 bulan full",
      "category": {
        "id": 2,
        "name": 'Puasa',
      },
    },
    {
      "id": 10,
      "name": 'Puasa Syawal',
      "icon": 'lib/assets/icons/no-food.png',
      "des": "Puasa yang dianjurkan setelah ramadhan",
      "category": {
        "id": 2,
        "name": 'Puasa',
      },
    },
    {
      "id": 11,
      "name": 'Puasa Dzulhijjah',
      "icon": 'lib/assets/icons/no-food.png',
      "des": "khususnya pada sepuluh hari pertama bulan Dzulhijjah",
      "category": {
        "id": 2,
        "name": 'Puasa',
      },
    },
    {
      "id": 12,
      "name": 'Puasa Arafah',
      "icon": 'lib/assets/icons/no-food.png',
      "des": "Dilakukan sehari sebelum Hari Raya Idul Adha. ",
      "category": {
        "id": 2,
        "name": 'Puasa',
      },
    },
    {
      "id": 13,
      "name": 'Puasa Tasua',
      "icon": 'lib/assets/icons/no-food.png',
      "des":
          "sehari sebelum puasa Asyura yang jatuh pada tanggal 10 Muharram. ",
      "category": {
        "id": 2,
        "name": 'Puasa',
      },
    },
    {
      "id": 14,
      "name": 'Puasa Asyura',
      "icon": 'lib/assets/icons/no-food.png',
      "des": "puasa sunnah yang dilakukan pada tanggal 10 Muharram",
      "category": {
        "id": 2,
        "name": 'Puasa',
      },
    },
    {
      "id": 15,
      "name": 'Puasa Senin',
      "icon": 'lib/assets/icons/no-food.png',
      "des": "puasa sunnah yang dilakukan pada hari Senin",
      "category": {
        "id": 2,
        "name": 'Puasa',
      },
    },
    {
      "id": 16,
      "name": 'Puasa kamis',
      "icon": 'lib/assets/icons/no-food.png',
      "des": "puasa sunnah yang dilakukan pada hari Kamis",
      "category": {
        "id": 2,
        "name": 'Puasa',
      },
    },
    {
      "id": 17,
      "name": 'Puasa Ayyamul Bidh',
      "icon": 'lib/assets/icons/no-food.png',
      "des": "puasa sunnah yang dilakukan pada tanggal 13, 14, dan 15",
      "category": {
        "id": 2,
        "name": 'Puasa',
      },
    },
    {
      "id": 18,
      "name": 'Sedakah Subuh',
      "icon": 'lib/assets/icons/zakat.png',
      "des": "Sedekah yang di saksikan oleh malaikat  ",
      "category": {
        "id": 4,
        "name": 'Sekedah & Zakat',
      },
    },
    {
      "id": 19,
      "name": 'Zakat Fitrah',
      "icon": 'lib/assets/icons/zakat.png',
      "des": "Zakat dikeluarkan oleh setiap Muslim pada bulan Ramadan ",
      "category": {
        "id": 4,
        "name": 'Sekedah & Zakat',
      },
    },
    {
      "id": 20,
      "name": 'Zikir Pagi',
      "icon": 'lib/assets/icons/zikir.png',
      "des": "Zikir untuk memohon perlindungan di pagi hari",
      "category": {
        "id": 5,
        "name": 'Zikir',
      },
    },
    {
      "id": 20,
      "name": 'Zikir Sore',
      "icon": 'lib/assets/icons/zikir.png',
      "des": "Zikir untuk memohon perlindungan di sore hari",
      "category": {
        "id": 5,
        "name": 'Zikir',
      },
    },
  ];

  final categories = [
    {
      "id": 1,
      "name": 'Sholat Wajib',
    },
    {
      "id": 2,
      "name": 'Puasa',
    },
    {
      "id": 3,
      "name": 'AlQuran & Hadist',
    },
    {
      "id": 4,
      "name": 'Sekedah & Zakat',
    },
    {
      "id": 5,
      "name": 'Zikir',
    },
  ].obs;

  final userActivities = [
    {
      "id": 1,
      "activity": {
        "id": 1,
        "name": "Sholat Magrib",
        "icon": "lib/assets/icons/mosque.png",
        "des": "17.57",
        "category": {"id": 1, "name": "Sholat Wajib"}
      },
      "date": DateTime.now()
    },
    {
      "id": 2,
      "activity": {
        "id": 2,
        "name": "Sholat Isya",
        "icon": "lib/assets/icons/mosque.png",
        "des": "19.06",
        "category": {"id": 1, "name": "Sholat Wajib"}
      },
      "date": DateTime.now()
    },
    {
      "id": 3,
      "activity": {
        "id": 3,
        "name": "Fajr",
        "icon": "lib/assets/icons/mosque.png",
        "des": "04.08",
        "category": {"id": 1, "name": "Sholat Wajib"}
      },
      "date": DateTime.now()
    },
    {
      "id": 4,
      "activity": {
        "id": 4,
        "name": "Sholat Dhuhur",
        "icon": "lib/assets/icons/mosque.png",
        "des": "11.45",
        "category": {"id": 1, "name": "Sholat Wajib"}
      },
      "date": DateTime.now()
    },
    {
      "id": 5,
      "activity": {
        "id": 5,
        "name": "Sholat Asar",
        "icon": "lib/assets/icons/mosque.png",
        "des": "15.13",
        "category": {"id": 1, "name": "Sholat Wajib"}
      },
      "date": DateTime.now()
    },
    {
      "id": 6,
      "activity": {
        "id": 6,
        "name": "Sholat Jum'at",
        "icon": "lib/assets/icons/mosque.png",
        "des": "12.06",
        "category": {"id": 1, "name": "Sholat Wajib"}
      },
      "date": DateTime.now()
    },
    {
      "id": 7,
      "activity": {
        "id": 7,
        "name": "Sholat Tarawih",
        "icon": "lib/assets/icons/mosque.png",
        "des": "19.30",
        "category": {"id": 1, "name": "Sholat Wajib"}
      },
      "date": DateTime.now()
    },
    {
      "id": 8,
      "activity": {
        "id": 8,
        "name": "Sholat Tahajud",
        "icon": "lib/assets/icons/mosque.png",
        "des": "03.00",
        "category": {"id": 1, "name": "Sholat Wajib"}
      },
      "date": DateTime.now()
    },
    {
      "id": 9,
      "activity": {
        "id": 9,
        "name": "Sholat Dhuha",
        "icon": "lib/assets/icons/mosque.png",
        "des": "08.00",
        "category": {"id": 1, "name": "Sholat Wajib"}
      },
      "date": DateTime.now()
    },
    {
      "id": 10,
      "activity": {
        "id": 10,
        "name": "Puasa Ramadhan",
        "icon": "lib/assets/icons/no-food.png",
        "des": "Umat Islam puasa ramadhan 1 bulan full",
        "category": {"id": 2, "name": "Puasa"}
      },
      "date": DateTime.now()
    },
    {
      "id": 11,
      "activity": {
        "id": 11,
        "name": "Puasa Syawal",
        "icon": "lib/assets/icons/no-food.png",
        "des": "Puasa yang dianjurkan setelah ramadhan",
        "category": {"id": 2, "name": "Puasa"}
      },
      "date": DateTime.now()
    },
    {
      "id": 12,
      "activity": {
        "id": 12,
        "name": "Puasa Dzulhijjah",
        "icon": "lib/assets/icons/no-food.png",
        "des": "khususnya pada sepuluh hari pertama bulan Dzulhijjah",
        "category": {"id": 2, "name": "Puasa"}
      },
      "date": DateTime.now()
    },
    {
      "id": 13,
      "activity": {
        "id": 13,
        "name": "Puasa Arafah",
        "icon": "lib/assets/icons/no-food.png",
        "des": "Dilakukan sehari sebelum Hari Raya Idul Adha.",
        "category": {"id": 2, "name": "Puasa"}
      },
      "date": DateTime.now()
    },
    {
      "id": 14,
      "activity": {
        "id": 14,
        "name": "Puasa Tasua",
        "icon": "lib/assets/icons/no-food.png",
        "des":
            "sehari sebelum puasa Asyura yang jatuh pada tanggal 10 Muharram.",
        "category": {"id": 2, "name": "Puasa"}
      },
      "date": DateTime.now()
    },
    {
      "id": 15,
      "activity": {
        "id": 15,
        "name": "Puasa Asyura",
        "icon": "lib/assets/icons/no-food.png",
        "des": "puasa sunnah yang dilakukan pada tanggal 10 Muharram",
        "category": {"id": 2, "name": "Puasa"}
      },
      "date": DateTime.now()
    },
    {
      "id": 16,
      "activity": {
        "id": 16,
        "name": "Puasa Senin",
        "icon": "lib/assets/icons/no-food.png",
        "des": "puasa sunnah yang dilakukan pada hari Senin",
        "category": {"id": 2, "name": "Puasa"}
      },
      "date": DateTime.now()
    },
    {
      "id": 17,
      "activity": {
        "id": 17,
        "name": "Puasa Kamis",
        "icon": "lib/assets/icons/no-food.png",
        "des": "puasa sunnah yang dilakukan pada hari Kamis",
        "category": {"id": 2, "name": "Puasa"}
      },
      "date": DateTime.now()
    },
    {
      "id": 18,
      "activity": {
        "id": 18,
        "name": "Puasa Ayyamul Bidh",
        "icon": "lib/assets/icons/no-food.png",
        "des": "puasa sunnah yang dilakukan pada tanggal 13, 14, dan 15",
        "category": {"id": 2, "name": "Puasa"}
      },
      "date": DateTime.now()
    },
    {
      "id": 19,
      "activity": {
        "id": 19,
        "name": "Sedakah Subuh",
        "icon": "lib/assets/icons/zakat.png",
        "des": "Sedekah yang di saksikan oleh malaikat",
        "category": {"id": 4, "name": "Sekedah & Zakat"}
      },
      "date": DateTime.now()
    },
    {
      "id": 20,
      "activity": {
        "id": 20,
        "name": "Zakat Fitrah",
        "icon": "lib/assets/icons/zakat.png",
        "des": "Zakat dikeluarkan oleh setiap Muslim pada bulan Ramadan",
        "category": {"id": 4, "name": "Sekedah & Zakat"}
      },
      "date": DateTime.now()
    },
    {
      "id": 21,
      "activity": {
        "id": 21,
        "name": "Zikir Pagi",
        "icon": "lib/assets/icons/zikir.png",
        "des": "Zikir untuk memohon perlindungan di pagi hari",
        "category": {"id": 5, "name": "Zikir"}
      },
      "date": DateTime.now()
    },
    {
      "id": 22,
      "activity": {
        "id": 22,
        "name": "Zikir Sore",
        "icon": "lib/assets/icons/zikir.png",
        "des": "Zikir untuk memohon perlindungan di sore hari",
        "category": {"id": 5, "name": "Zikir"}
      },
      "date": DateTime.now()
    }
  ].obs;

  final userActivityLogs = <dynamic>[].obs;

  final RxList<Map<String, String>> prayerTimes = <Map<String, String>>[].obs;

  Future<void> fetchPrayerTimes() async {
    const String url =
        "http://api.aladhan.com/v1/timingsByCity?city=Makassar&country=Indonesia&method=2";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final timings = data['data']['timings'];

        prayerTimes.clear();
        prayerTimes.add({
          'time': timings['Fajr'],
          'name': 'Fajar',
          'image': 'lib/assets/icons/clouds.png',
        });
        prayerTimes.add({
          'time': timings['Dhuhr'],
          'name': 'Dhuhur',
          'image': 'lib/assets/icons/sun.png',
        });
        prayerTimes.add({
          'time': timings['Asr'],
          'name': 'Ashar',
          'image': 'lib/assets/icons/rainy-day.png',
        });
        prayerTimes.add({
          'time': timings['Maghrib'],
          'name': 'Maghrib',
          'image': 'lib/assets/icons/sun.png',
        });
        prayerTimes.add({
          'time': timings['Isha'],
          'name': 'Isya',
          'image': 'lib/assets/icons/cloudy.png',
        });
      } else {
        print("Failed to load prayer times");
      }
    } catch (e) {
      print("Error fetching prayer times: $e");
    }
  }

  final RxMap<int, String> hijriMonthsIndonesia = {
    1: 'Muharram',
    2: 'Safar',
    3: 'Rabiul Awal',
    4: 'Rabiul Akhir',
    5: 'Jumadil Awal',
    6: 'Jumadil Akhir',
    7: 'Rajab',
    8: 'Sya\'ban',
    9: 'Ramadhan',
    10: 'Syawal',
    11: 'Dzulqa\'idah',
    12: 'Dzulhijjah',
  }.obs;

  final RxMap<int, String> daysOfWeekIndonesia = {
    1: 'Senin',
    2: 'Selasa',
    3: 'Rabu',
    4: 'Kamis',
    5: "Jum'at",
    6: 'Sabtu',
    7: "Ahad",
  }.obs;

  void addUserActivityLog(Map<String, dynamic> log) {
    final DateTime now = DateTime.now();
    final DateTime logDate = log['completed_at'] is DateTime
        ? log['completed_at']
        : DateTime.parse(log['completed_at']);

    // Validate the log date
    if (logDate.isAfter(now)) {
      throw Exception("Activity log cannot be set for a future date.");
    }

    // Ensure the date is stored in ISO format
    if (log['completed_at'] is DateTime) {
      log['completed_at'] = (log['completed_at'] as DateTime).toIso8601String();
    }

    // Add day and time to the log
    log['day'] = logDate.toIso8601String().split('T')[0];
    log['time'] = logDate.toIso8601String().split('T')[1];

    userActivityLogs.add(log);
    saveUserActivities();
  }

  void removeUserActivityLog(int activityId) {
    userActivityLogs.removeWhere((log) => log['activity_id'] == activityId);
    saveUserActivities();
    update();
  }

  void saveUserActivities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> logsToSave = userActivityLogs.map((log) {
      Map<String, dynamic> logToSave = Map.from(log);
      if (logToSave['completed_at'] is DateTime) {
        logToSave['completed_at'] =
            (logToSave['completed_at'] as DateTime).toIso8601String();
      }
      return logToSave;
    }).toList();
    await prefs.setString('userActivityLogs', jsonEncode(logsToSave));
  }

  Future<void> loadUserActivityLogs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLogs = prefs.getString('userActivityLogs');
    if (savedLogs != null) {
      List<dynamic> logs = jsonDecode(savedLogs);

      // Mengonversi setiap log ke format yang benar
      userActivityLogs.assignAll(
        logs.map((log) {
          if (log['completed_at'] is String) {
            log['completed_at'] = DateTime.parse(log['completed_at']);
          }
          return log as Map<String, dynamic>;
        }).toList(),
      );
    }
  }

  List<Map<String, dynamic>> getActivityLogsForDate(DateTime date) {
    return userActivityLogs
        .where((log) {
          DateTime completedAt;
          if (log['completed_at'] is String) {
            completedAt = DateTime.parse(log['completed_at']);
          } else if (log['completed_at'] is DateTime) {
            completedAt = log['completed_at'];
          } else {
            throw Exception('Invalid type for completed_at');
          }

          // Bandingkan Tanggal
          return completedAt.year == date.year &&
              completedAt.month == date.month &&
              completedAt.day == date.day;
        })
        .toList()
        .cast<Map<String, dynamic>>();
  }
}
