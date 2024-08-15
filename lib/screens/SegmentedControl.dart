import 'package:flutter/material.dart';

class SegmentedControl extends StatelessWidget {
  final List<String> values;
  final String selectedValue;
  final ValueChanged<String> onValueChanged;

  const SegmentedControl({
    required this.values,
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: values.map((value) {
        final isSelected = value == selectedValue;
        return GestureDetector(
          onTap: () => onValueChanged(value),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
