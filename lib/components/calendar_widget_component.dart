import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class CalendarWidgetComponent extends StatelessWidget {
  const CalendarWidgetComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Calendar(
        startOnMonday: false,
        weekDays: const [
          'Mo',
          'Di',
          'Mi',
          'Do',
          'Fr',
          'Sa',
          'So',
        ],
        events: const {},
        isExpandable: true,
        eventDoneColor: Colors.green,
        selectedColor: Colors.pink,
        todayColor: Colors.blue,
        eventColor: Colors.grey,
        locale: 'de_DE',
        todayButtonText: 'Heute',
        expandableDateFormat: 'EEEE, dd. MMMM yyyy',
        dayOfWeekStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontSize: 11,
        ),
      ),
    );
  }
}
