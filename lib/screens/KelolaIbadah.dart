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

  @override
  void initState() {
    super.initState();
    _loadSavedIcons();
  }

  Future<void> _loadSavedIcons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      app.ibadahItems.forEach((category, items) {
        for (var item in items) {
          // String? savedIconPath = prefs.getString(item['text']!);
          String? savedIconPath = prefs.getString('${item['text']}_iconPath');
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
      app.ibadahItems.forEach((category, items) {
        for (var item in items) {
          if (item['text'] == name) {
            item['imagePath'] = newIconPath;
            prefs.setString('$item', newIconPath);
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
    app.ibadahItems.forEach((title, items) {
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
