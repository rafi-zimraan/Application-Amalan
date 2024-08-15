import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:giveup/Controller/App_controller.dart';

class ActivityTileTodayComponent extends StatelessWidget {
  final Map<String, dynamic> activity;
  final bool isCompleted;
  final bool isBloked;
  final Function(bool?)? onChanged;
  final DateTime selectedDay;

  const ActivityTileTodayComponent({
    super.key,
    required this.activity,
    required this.isCompleted,
    required this.isBloked,
    required this.selectedDay,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final AppControler app = Get.find();

    return ListTile(
      leading: Image.asset(activity['icon']),
      title: Text(activity['name']),
      subtitle: Row(
        children: [
          Expanded(child: Text(activity['des'])),
          if (isCompleted)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 13.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'lib/assets/icons/check.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Tercapai',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      trailing: Checkbox(
        value: isCompleted,
        onChanged: (bool? newValue) {
          if (isBloked) {
            onChanged?.call(newValue);
          } else {
            Fluttertoast.showToast(
              msg: "Tidak bisa dicentang pada tanggal ini",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
          }
        },
        activeColor: Colors.blue,
        checkColor: Colors.white,
      ),
    );
  }
}
