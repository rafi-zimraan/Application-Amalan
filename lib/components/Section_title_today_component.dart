// lib/components/section_title.dart
import 'package:flutter/material.dart';

class SectionTitleTodayComponent extends StatelessWidget {
  final String title;

  const SectionTitleTodayComponent({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
