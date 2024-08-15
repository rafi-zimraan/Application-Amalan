import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class DateDisplayIbadahComponent extends StatelessWidget {
  final DateTime selectedDay;
  final Map<int, String> hijriMonthsIndonesia;
  final Map<int, String> daysOfWeekIndonesia;

  const DateDisplayIbadahComponent({
    super.key,
    required this.selectedDay,
    required this.hijriMonthsIndonesia,
    required this.daysOfWeekIndonesia,
  });

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal("ar");
    HijriCalendar hijriNow = HijriCalendar.fromDate(selectedDay);

    String masehiDay = DateFormat('EEEE', 'id_ID').format(selectedDay);
    String masehiDate = DateFormat("dd-MM-yyyy").format(selectedDay);
    String hijriIndonesia = hijriMonthsIndonesia[hijriNow.hMonth] ?? '';
    String hijriDay = daysOfWeekIndonesia[selectedDay.weekday] ?? '';
    String hijriDate = '${hijriNow.hDay} $hijriIndonesia ${hijriNow.hYear}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$hijriDay $hijriDate",
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Text(
          "$masehiDay, $masehiDate",
          style: const TextStyle(fontSize: 17, color: Colors.grey),
        ),
      ],
    );
  }
}
