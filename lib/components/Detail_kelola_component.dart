import 'package:flutter/material.dart';

class DetailKelolaComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool hasSwitch;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  const DetailKelolaComponent({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.hasSwitch = false,
    this.switchValue,
    this.onSwitchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 30, color: Colors.grey),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const Spacer(),
        if (hasSwitch)
          Switch(
            value: switchValue!,
            onChanged: onSwitchChanged,
          )
        else
          const Icon(
            Icons.arrow_forward_ios,
            size: 30,
            color: Colors.grey,
          ),
      ],
    );
  }
}
