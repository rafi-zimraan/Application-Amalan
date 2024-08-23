import 'package:flutter/material.dart';

class ActivityHabitSelector extends StatelessWidget {
  final ValueChanged<String> onSelectionMade;

  const ActivityHabitSelector({super.key, required this.onSelectionMade});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Activity',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              ListTile(
                title: const Text(
                  'Activity',
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  onSelectionMade('Activity');
                  Navigator.of(context).pop();
                },
              ),
              const Divider(color: Colors.black26, height: 1),
            ],
          ),
          Column(
            children: [
              ListTile(
                title: const Text(
                  'Habit',
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  onSelectionMade('Habit');
                  Navigator.of(context).pop();
                },
              ),
              const Divider(color: Colors.black26, height: 1),
            ],
          ),
        ],
      ),
    );
  }
}
