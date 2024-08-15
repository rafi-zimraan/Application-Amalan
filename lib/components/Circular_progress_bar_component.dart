import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class CircularProgressBarComponent extends StatelessWidget {
  final ValueNotifier<double> valueNotifier;

  const CircularProgressBarComponent({required this.valueNotifier, super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleCircularProgressBar(
      valueNotifier: valueNotifier,
      mergeMode: true,
      onGetText: (double value) {
        return Text(
          '${value.toInt()}',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        );
      },
    );
  }
}
