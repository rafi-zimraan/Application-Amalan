import 'package:flutter/material.dart';

class KelolaListItemComponent extends StatelessWidget {
  final String imagePath;
  final String text;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onTap;
  final IconData? icon;

  const KelolaListItemComponent({
    required this.imagePath,
    required this.text,
    required this.isChecked,
    required this.onChanged,
    required this.onTap,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        icon != null
            ? Icon(icon, size: 45)
            : Image.asset(
                imagePath,
                width: 45,
                height: 45,
              ),
        const SizedBox(width: 25),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: onTap,
        ),
      ],
    );
  }
}
