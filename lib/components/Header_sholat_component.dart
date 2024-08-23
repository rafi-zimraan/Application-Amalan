import 'package:flutter/material.dart';

class HeaderSholatComponent extends StatelessWidget {
  final String location;

  const HeaderSholatComponent({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white),
              const SizedBox(width: 15),
              Text(
                location,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Row(
              children: [
                Icon(Icons.explore, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Kiblat',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
