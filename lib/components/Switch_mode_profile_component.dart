import 'package:flutter/material.dart';

class SwitchModeProfileComponent extends StatelessWidget {
  final String iconPath;
  final String title;
  final String info;
  final bool value;
  final ValueChanged<bool> onChanged;
  final VoidCallback onInfoPressed;

  const SwitchModeProfileComponent({
    super.key,
    required this.iconPath,
    required this.title,
    required this.info,
    required this.value,
    required this.onChanged,
    required this.onInfoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(iconPath, height: 30),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 5),
        IconButton(
          icon: const Icon(Icons.info_outline, color: Colors.grey),
          onPressed: onInfoPressed,
        ),
        const Spacer(),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
        ),
      ],
    );
  }
}
