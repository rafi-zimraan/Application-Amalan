import 'package:flutter/material.dart';

class ReminderSelectionWidget extends StatelessWidget {
  const ReminderSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.timer, size: 50),
          SizedBox(height: 10),
          Text('Pilih Pengingat'),
          // Tambahkan widget pemilihan pengingat lainnya
        ],
      ),
    );
  }
}
