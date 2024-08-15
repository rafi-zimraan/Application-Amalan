import 'package:flutter/material.dart';

class NextPrayerSholatComponent extends StatelessWidget {
  final String nextPrayer;
  final String nextPrayerTime;
  final String timeToNextPrayer;

  const NextPrayerSholatComponent({
    super.key,
    required this.nextPrayer,
    required this.nextPrayerTime,
    required this.timeToNextPrayer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.withOpacity(0.5), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            nextPrayer,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            nextPrayerTime,
            style: const TextStyle(
              fontSize: 44,
              color: Colors.white,
            ),
          ),
          Text(
            timeToNextPrayer,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
