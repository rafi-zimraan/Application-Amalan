import 'package:flutter/material.dart';

class NotificationSelectionWidget extends StatelessWidget {
  const NotificationSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_active_rounded, size: 50),
          SizedBox(height: 10),
          Text('Pilih Jenis Notifikasi'),
          // Tambahkan widget pemilihan notifikasi lainnya
        ],
      ),
    );
  }
}
