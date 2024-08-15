// lib/components/bottom_sheet_content.dart
import 'package:flutter/material.dart';
import 'package:giveup/components/Bottom_sheet_tile_today_component.dart';
import 'package:giveup/screens/KelolaIbadah.dart';

class BottomSheetContentTodayComponent extends StatelessWidget {
  const BottomSheetContentTodayComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          // BottomSheetTileTodayComponent(
          //   icon: Icons.add_chart,
          //   title: "Tempat Ibadah",
          //   subtitle:
          //       "Pilih ibadah dari daftar rekomendasi atau buat baru sesuai kebutuhan anda.",
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const SelectedNewIbadah(),
          //       ),
          //     );
          //   },
          // ),
          BottomSheetTileTodayComponent(
            icon: Icons.settings,
            title: "Kelola Ibadah",
            subtitle: "Atur pengingat dan target ibadah anda.",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const KelolaIbadah(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
