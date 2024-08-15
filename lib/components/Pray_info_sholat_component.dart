import 'package:flutter/material.dart';

class PrayInfoSholatComponent extends StatefulWidget {
  final String time;
  final String prayerName;
  final String image;
  final Color backgroundColor;

  const PrayInfoSholatComponent({
    super.key,
    required this.time,
    required this.prayerName,
    required this.image,
    this.backgroundColor = Colors.transparent,
  });

  @override
  State<PrayInfoSholatComponent> createState() =>
      _PrayInfoSholatComponentState();
}

class _PrayInfoSholatComponentState extends State<PrayInfoSholatComponent> {
  // final AudioPlayer _audioPlayer = AudioPlayer();
  // bool _isPlaying = false;

  // Future<void> _togglePlayAdzan() async {
  //   try {
  //     if (_isPlaying) {
  //       await _audioPlayer.stop();
  //     } else {
  //       print('Playing asset: lib/assets/sounds/adzan.mp3');
  //       await _audioPlayer.play(AssetSource('sounds/adzan.mp3'));
  //     }
  //     setState(() {
  //       _isPlaying = !_isPlaying;
  //     });
  //   } catch (e) {
  //     print('Error playing audio: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.backgroundColor,
        ),
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Image.asset(
              widget.image,
              width: 35,
              height: 35,
            ),
            const SizedBox(width: 40),
            Text(
              widget.time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 50),
            Text(
              widget.prayerName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            const Spacer(),
            const Icon(Icons.volume_down),

            // const Icon(Icons.play_arrow),
          ],
        ),
      ),
    );
  }
}
