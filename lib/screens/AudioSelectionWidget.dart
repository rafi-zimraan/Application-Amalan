import 'package:flutter/material.dart';

class AudioSelectionWidget extends StatelessWidget {
  const AudioSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.multitrack_audio_sharp, size: 50),
          SizedBox(height: 10),
          Text('Pilih Audio'),
          // Tambahkan widget pemilihan audio lainnya
        ],
      ),
    );
  }
}
