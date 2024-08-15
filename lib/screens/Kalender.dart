import 'package:flutter/material.dart';
import 'package:giveup/components/Info_calendar_component.dart';
import 'package:giveup/components/Text_calendar_component.dart';
import 'package:giveup/components/calendar_widget_component.dart';
import 'package:giveup/components/divider_space_calendar_component.dart';

class Kalender extends StatelessWidget {
  const Kalender({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CalendarWidgetComponent(),
              SizedBox(height: 15),
              InfoCalendarComponent(
                icon: Icons.link,
                text: 'Streak',
                iconPadding: 129,
              ),
              SizedBox(height: 26),
              TextCalendarComponent(
                text: '0 Angka',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 15),
              DividerSpaceCalendarComponent(space: 10),
              InfoCalendarComponent(
                icon: Icons.info_outline,
                text: 'Description',
                iconPadding: 114,
              ),
              SizedBox(height: 30),
              TextCalendarComponent(
                text: 'Push up 20',
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 15),
              DividerSpaceCalendarComponent(space: 10),
              InfoCalendarComponent(
                icon: Icons.message_outlined,
                text: 'Notes',
                iconPadding: 130,
              ),
              SizedBox(height: 30),
              TextCalendarComponent(
                text: 'No notes for this month',
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
