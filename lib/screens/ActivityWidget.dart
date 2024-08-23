import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveup/screens/SelectableButtonActivity.dart';

class ActivityWidget extends StatefulWidget {
  final List<Map<String, dynamic>> activities;

  const ActivityWidget({super.key, required this.activities});

  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  int? _selectedActivityIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(width: 45),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SelectableButtonActivity(
                text: "All",
                onTap: () {},
              ),
              const SizedBox(width: 10),
              SelectableButtonActivity(
                text: "New Activity",
                icon: Icons.format_list_bulleted_add,
                onTap: () {},
                isSpecialButton: true,
              ),
              const SizedBox(width: 10),
              Obx(
                () {
                  return Row(
                    children: widget.activities.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> activity = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedActivityIndex =
                                  _selectedActivityIndex == index
                                      ? null
                                      : index;
                            });
                          },
                          child: SelectableButtonActivity(
                            text: activity['activity']['name'],
                            icon: IconData(
                              activity['activity']['icon'],
                              fontFamily: 'MaterialIcons',
                            ),
                            onTap: () {},
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        if (_selectedActivityIndex != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(IconData(
                    widget.activities[_selectedActivityIndex!]['activity']
                        ['icon'],
                    fontFamily: 'MaterialIcons',
                  )),
                  const SizedBox(width: 10),
                  Text(widget.activities[_selectedActivityIndex!]['activity']
                      ['name']),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      'Selected Option: ${widget.activities[_selectedActivityIndex!]['selectedOption']}'),
                  const SizedBox(height: 5),
                  const Icon(Icons.access_time),
                ],
              ),
            ],
          ),
      ],
    );
  }
}
