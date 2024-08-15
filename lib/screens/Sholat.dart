import 'dart:async'; // Import untuk Timer

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveup/Controller/App_controller.dart';
import 'package:giveup/components/Date_sholat_component.dart';
import 'package:giveup/components/Header_sholat_component.dart';
import 'package:giveup/components/Next_prayer_sholat_component.dart';
import 'package:giveup/components/Pray_info_sholat_component.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class Sholat extends StatefulWidget {
  const Sholat({super.key});

  @override
  _SholatState createState() => _SholatState();
}

class _SholatState extends State<Sholat> {
  final AppControler appController = Get.find();
  final String _location = "Bandung";
  String _currentTime = "";
  String _nextPrayer = "";
  String _timeToNextPrayer = "";
  String _nextPrayerTime = "";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    appController.fetchPrayerTimes();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          DateTime now = DateTime.now();
          _currentTime = DateFormat('HH:mm:ss').format(now);
          _updatePrayerTimes(now);
        });
      }
    });
  }

  void _updatePrayerTimes(DateTime now) {
    final prayerTimes = appController.prayerTimes;

    if (prayerTimes.isEmpty) return;

    String nextPrayer = 'Fajr';
    Duration timeToNextPrayer = const Duration(hours: 24);
    DateTime nextPrayerTime =
        DateFormat('HH:mm').parse(prayerTimes[0]['time']!);

    for (var prayer in prayerTimes) {
      DateTime prayerTime = DateFormat('HH:mm').parse(prayer['time']!);
      prayerTime = DateTime(
          now.year, now.month, now.day, prayerTime.hour, prayerTime.minute);

      if (now.isBefore(prayerTime) &&
          prayerTime.difference(now) < timeToNextPrayer) {
        nextPrayer = prayer['name']!;
        nextPrayerTime = prayerTime;
        timeToNextPrayer = prayerTime.difference(now);
      }
    }

    setState(() {
      _nextPrayer = nextPrayer;
      _nextPrayerTime = DateFormat('HH:mm').format(nextPrayerTime);
      _timeToNextPrayer =
          '${timeToNextPrayer.inHours} jam ${timeToNextPrayer.inMinutes % 60} menit ${timeToNextPrayer.inSeconds % 60} detik';
    });
  }

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal("ar");
    HijriCalendar hijriNow = HijriCalendar.now();

    String masehiDay = DateFormat('EEEE', 'id_ID').format(DateTime.now());
    String masehiDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    String hijriIndonesia =
        appController.hijriMonthsIndonesia[hijriNow.hMonth] ?? '';
    String hijriDay =
        appController.daysOfWeekIndonesia[DateTime.now().weekday] ?? '';
    String hijriDate = '${hijriNow.hDay} $hijriIndonesia ${hijriNow.hYear}';

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.8,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/mountains.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                HeaderSholatComponent(location: _location),
                NextPrayerSholatComponent(
                  nextPrayer: _nextPrayer,
                  timeToNextPrayer: _timeToNextPrayer,
                  nextPrayerTime: _nextPrayerTime,
                ),
              ],
            ),
          ),
          DateSholatComponent(
            hijriDay: hijriDay,
            hijriDate: hijriDate,
            masehiDay: masehiDay,
            masehiDate: masehiDate,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  children: appController.prayerTimes.map((prayer) {
                    bool isNextPrayer = prayer['name'] == _nextPrayer;
                    return PrayInfoSholatComponent(
                      time: prayer['time']!,
                      prayerName: prayer['name']!,
                      image: prayer['image'] ?? 'default_image.png',
                      backgroundColor:
                          isNextPrayer ? Colors.lightBlue : Colors.transparent,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
