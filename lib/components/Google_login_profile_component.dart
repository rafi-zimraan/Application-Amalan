import 'package:flutter/material.dart';

class GoogleLoginProfileComponent extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleLoginProfileComponent({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Image.asset('lib/assets/icons/google.png', height: 27),
      label: const Text("Masuk dengan Google"),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
    );
  }
}
