import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class CalendarDisplayIbadahComponent extends StatelessWidget {
  final DateTime selectedDay;
  final void Function(DateTime) onDateSelected;
  final Map<DateTime, List<CleanCalendarEvent>> events;

  const CalendarDisplayIbadahComponent({
    super.key,
    required this.selectedDay,
    required this.onDateSelected,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    final dateNow = DateTime.now();
    // final weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fir', 'Sat'];

    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // children: weekDays.map((day) {
          //   return Container(
          //     margin: const EdgeInsets.all(2.0),
          //     child: Center(
          //       child: Text(
          //         day,
          //         style: const TextStyle(
          //           color: Colors.black,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   );
          // }).toList(),
        ),
        SizedBox(
          height: 130,
          child: Calendar(
            startOnMonday: false,
            weekDays: const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fir', 'Sat'],
            events: events,
            isExpandable: false,
            eventDoneColor: Colors.green,
            selectedColor: Colors.pink,
            todayColor: Colors.blue,
            eventColor: Colors.grey,
            locale: 'en_US',
            todayButtonText: 'Today',
            expandableDateFormat: 'EEEE, dd. MMMM yyyy',
            dayOfWeekStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 11,
            ),
            onDateSelected: onDateSelected,
            dayBuilder: (context, day) {
              final isToday = day.year == dateNow.year &&
                  day.month == dateNow.month &&
                  day.day == dateNow.day;
              final isPastDate = day.isBefore(dateNow);
              final isSelected = day.year == selectedDay.year &&
                  day.month == selectedDay.month &&
                  day.day == selectedDay.day;

              return GestureDetector(
                onTap: () {
                  onDateSelected(day);
                },
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.orange
                        : (isToday
                            ? Colors.blue
                            : (isPastDate ? Colors.grey : Colors.transparent)),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isPastDate ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
