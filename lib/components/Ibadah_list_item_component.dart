import 'package:flutter/material.dart';

class IbadahListItemComponent extends StatelessWidget {
  final String imagePath;
  final String text;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const IbadahListItemComponent({
    required this.imagePath,
    required this.text,
    required this.isChecked,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Image.asset(imagePath, width: 45, height: 45),
        const SizedBox(width: 25),
        Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
        const SizedBox(height: 30),
        const Spacer(),
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
