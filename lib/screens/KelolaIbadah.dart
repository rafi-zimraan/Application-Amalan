import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveup/Controller/App_controller.dart';
import 'package:giveup/components/Kelola_list_item_component.dart';
import 'package:giveup/components/Kelola_section_component.dart';
import 'package:giveup/screens/DetailKelolaIbadah.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KelolaIbadah extends StatefulWidget {
  const KelolaIbadah({super.key});

  @override
  _KelolaIbadahState createState() => _KelolaIbadahState();
}

class _KelolaIbadahState extends State<KelolaIbadah> {
  final AppControler app = Get.find();

  final Map<String, List<Map<String, String>>> ibadahItems = {
    'Sholat': [
      {'text': 'Magrib', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Isya', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Salat Tahajud', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Subuh', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Salat Duha', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Jumat', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Zuhur', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Asar', 'imagePath': 'lib/assets/icons/mosque.png'},
      {'text': 'Salat Tarawih', 'imagePath': 'lib/assets/icons/mosque.png'},
    ],
    'Puasa': [
      {'text': 'Puasa Ramadhan', 'imagePath': 'lib/assets/icons/no-food.png'},
      {'text': 'Puasa Syawal', 'imagePath': 'lib/assets/icons/no-food.png'},
      {'text': 'Puasa Dzulhijjah', 'imagePath': 'lib/assets/icons/no-food.png'},
      {'text': 'Puasa Arafah', 'imagePath': 'lib/assets/icons/no-food.png'},
      {'text': 'Puasa Tasua', 'imagePath': 'lib/assets/icons/no-food.png'},
      {'text': 'Puasa Senin', 'imagePath': 'lib/assets/icons/no-food.png'},
      {'text': 'Puasa Kamis', 'imagePath': 'lib/assets/icons/no-food.png'},
      {'text': 'Ayyamul Bidh', 'imagePath': 'lib/assets/icons/no-food.png'},
    ],
    'Al-Quran & Hadist': [
      {'text': 'Baca AlQuran', 'imagePath': 'lib/assets/icons/alQuran.png'},
      {
        'text': 'Baca Surah Alkahfi',
        'imagePath': 'lib/assets/icons/alQuran.png'
      },
    ],
    'Sedekah & Zakat': [
      {'text': 'Zakat Fitrah', 'imagePath': 'lib/assets/icons/zakat.png'},
      {'text': 'Sedekah Subuh', 'imagePath': 'lib/assets/icons/zakat.png'},
      {'text': 'Zakat Mal', 'imagePath': 'lib/assets/icons/zakat.png'},
      {'text': 'Sedekah Jumat', 'imagePath': 'lib/assets/icons/zakat.png'},
    ],
    'Zikir': [
      {'text': 'Zikir Pagi', 'imagePath': 'lib/assets/icons/zikir.png'},
      {'text': 'Zikir Sore', 'imagePath': 'lib/assets/icons/zikir.png'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _loadSavedIcons();
  }

  Future<void> _loadSavedIcons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ibadahItems.forEach((category, items) {
        for (var item in items) {
          String? savedIconPath = prefs.getString(item['text']!);
          if (savedIconPath != null) {
            item['imagePath'] = savedIconPath;
          }
        }
      });
    });
  }

  void _updateIcon(String name, String newIconPath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ibadahItems.forEach((category, items) {
        for (var item in items) {
          if (item['text'] == name) {
            item['imagePath'] = newIconPath;
            prefs.setString(name, newIconPath);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Kelola Ibadah Anda"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildIbadahSections(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildIbadahSections() {
    List<Widget> sections = [];
    ibadahItems.forEach((title, items) {
      sections.add(
        KelolaSectionComponent(
          title: title,
          items: items.expand((item) {
            return [
              KelolaListItemComponent(
                imagePath: item['imagePath']!,
                text: item['text']!,
                isChecked: true,
                onChanged: (bool? value) {},
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailKelolaIbadah(
                        title: item['text']!,
                        category: title,
                        bolehDilakukanSaatHaid: false,
                        onBolehDilakukanSaatHaidChanged: (bool newValue) {},
                        onSaveIcon: (String icon) {
                          _updateIcon(item['text']!, icon);
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ];
          }).toList(),
        ),
      );
      sections.add(const SizedBox(height: 20));
    });

    return sections;
  }
}
