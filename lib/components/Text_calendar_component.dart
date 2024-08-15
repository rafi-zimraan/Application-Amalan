import 'package:flutter/material.dart';

class TextCalendarComponent extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const TextCalendarComponent({
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
