import 'package:flutter/material.dart';

class InfoCalendarComponent extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconPadding;

  const InfoCalendarComponent({
    required this.icon,
    required this.text,
    required this.iconPadding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
        SizedBox(width: iconPadding),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
