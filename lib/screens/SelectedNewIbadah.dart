import 'package:flutter/material.dart';
import 'package:giveup/components/Ibadah_list_item_component.dart';
import 'package:giveup/components/Ibadah_section_component.dart';

class SelectedNewIbadah extends StatefulWidget {
  const SelectedNewIbadah({super.key});

  @override
  _SelectedNewIbadahState createState() => _SelectedNewIbadahState();
}

class _SelectedNewIbadahState extends State<SelectedNewIbadah> {
  Map<String, bool> ibadahChecks = {
    'Magrib': false,
    'Isya': false,
    'Salat Tahajud': false,
    'Subuh': false,
    'Salat Duha': false,
    'Jumat': false,
    'Zuhur': false,
    'Asar': false,
    'Salat Tarawih': false,
    'Puasa Ramadhan': false,
    'Puasa Syawal': false,
    'Puasa Dzulhijjah': false,
    'Puasa Arafah': false,
    'Puasa Tasua': false,
    'Asyura': false,
    'Puasa Senin': false,
    'Puasa Kamis': false,
    'Ayyamul Bidh': false,
    'Baca AlQuran': false,
    'Baca Surah Alkahfi': false,
    'Zakat Fitrah': false,
    'Sedekah Subuh': false,
    'Zakat Mal': false,
    'Sedekah Jumat': false,
    'Zikir Pagi': false,
    'Zikir Sore': false,
  };

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
        title: const Text("Pilih Ibadah untuk ditambah"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildIbadahSections() +
                    [
                      const SizedBox(height: 120),
                    ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.blue, width: 0.7),
                      ),
                      child: const Text(
                        "Tambah Ibadah Custom",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Save logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        "Simpan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildIbadahSections() {
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
        {
          'text': 'Puasa Dzulhijjah',
          'imagePath': 'lib/assets/icons/no-food.png'
        },
        {'text': 'Puasa Arafah', 'imagePath': 'lib/assets/icons/no-food.png'},
        {'text': 'Puasa Tasua', 'imagePath': 'lib/assets/icons/no-food.png'},
        {'text': 'Puasa Asyura', 'imagePath': 'lib/assets/icons/no-food.png'},
        {'text': 'Puasa Senin', 'imagePath': 'lib/assets/icons/no-food.png'},
        {'text': 'Puasa Kamis', 'imagePath': 'lib/assets/icons/no-food.png'},
        {
          'text': 'Puasa Ayyamul Bidh',
          'imagePath': 'lib/assets/icons/no-food.png'
        },
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

    List<Widget> sections = [];
    ibadahItems.forEach((title, items) {
      sections.add(
        IbadahSectionComponent(
          title: title,
          items: items.map((item) {
            return IbadahListItemComponent(
              imagePath: item['imagePath']!,
              text: item['text']!,
              isChecked: ibadahChecks[item['text']] ?? false,
              onChanged: (bool? value) {
                setState(() {
                  ibadahChecks[item['text']!] = value ?? false;
                });
              },
            );
          }).toList(),
        ),
      );
    });
    return sections;
  }
}
