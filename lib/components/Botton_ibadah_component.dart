import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveup/Controller/App_controller.dart';

class ButtonIbadahComponent extends StatelessWidget {
  const ButtonIbadahComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final AppControler app = Get.find();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(90, 36),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(width: 0.7),
            ),
            elevation: 2,
          ),
          icon: const Icon(Icons.post_add_outlined, size: 20),
          label: const Text('New List', style: TextStyle(fontSize: 13)),
        ),
        const SizedBox(width: 120),
        IntrinsicWidth(
          child: ElevatedButton.icon(
            onPressed: () {
              app.initialTabIndex.value = 0;
              app.activeTab.value = 2; // Statistik tab
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 35),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            icon: const Icon(Icons.calendar_month_sharp, size: 20),
            label: const SizedBox.shrink(),
          ),
        ),
        const SizedBox(width: 5),
        IntrinsicWidth(
          child: ElevatedButton.icon(
            onPressed: () {
              app.initialTabIndex.value = 1;
              app.activeTab.value = 2; // Statistik tab
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 35),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            icon: const Icon(Icons.bar_chart, size: 20),
            label: const SizedBox.shrink(),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
