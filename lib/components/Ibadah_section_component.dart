import 'package:flutter/material.dart';
import 'package:giveup/components/Ibadah_list_item_component.dart';

class IbadahSectionComponent extends StatelessWidget {
  final String title;
  final List<IbadahListItemComponent> items;

  const IbadahSectionComponent({
    required this.title,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...items,
        const Divider(),
      ],
    );
  }
}
