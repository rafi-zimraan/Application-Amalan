import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

void shareContent() async {
  await FlutterShare.share(
    title: 'Check out my portfolio',
    text: 'https://rafi-zimraan.github.io/portofolio/',
    chooserTitle: 'Share using',
  );
}

class DateSholatComponent extends StatelessWidget {
  final String hijriDay;
  final String hijriDate;
  final String masehiDay;
  final String masehiDate;

  const DateSholatComponent({
    super.key,
    required this.hijriDay,
    required this.hijriDate,
    required this.masehiDay,
    required this.masehiDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$hijriDay $hijriDate",
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "$masehiDay, $masehiDate",
                    style: const TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: 0.7),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  "Hari ini",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(color: Colors.grey, height: 1, thickness: 1),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "KEMENAG",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.arrow_drop_down),
              const SizedBox(width: 147),
              GestureDetector(
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                },
                child: const Icon(Icons.calendar_today),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: shareContent,
                child: const Icon(Icons.share),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
