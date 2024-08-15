import 'package:flutter/material.dart';

class KelolaSectionComponent extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const KelolaSectionComponent({
    required this.title,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Column(
          children: items,
        ),
      ],
    );
  }
}
