import 'package:flutter/material.dart';

class DividerSpaceCalendarComponent extends StatelessWidget {
  final double space;

  const DividerSpaceCalendarComponent({required this.space, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        SizedBox(height: space),
      ],
    );
  }
}
