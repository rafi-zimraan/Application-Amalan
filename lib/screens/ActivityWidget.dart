import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ActivityWidget extends StatefulWidget {
  final String listName;
  final IconData? selectedIcon;
  final String selectedOption;

  const ActivityWidget({
    super.key,
    required this.listName,
    this.selectedIcon,
    required this.selectedOption,
  });

  @override
  State<ActivityWidget> createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  bool isChecked = false;

  void _onCheckboxChanged(bool? value) {
    setState(() {
      isChecked = value ?? false;
      if (isChecked) {
        Fluttertoast.showToast(
          msg: "Berhasil menyimpan activity",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (widget.selectedIcon != null)
                        Icon(
                          widget.selectedIcon,
                          size: 30,
                        ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.listName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            widget.selectedOption,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Checkbox(
                    value: isChecked,
                    shape: const CircleBorder(),
                    onChanged: _onCheckboxChanged,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
