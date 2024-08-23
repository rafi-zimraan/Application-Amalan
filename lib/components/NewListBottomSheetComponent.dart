import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveup/Controller/App_controller.dart';
import 'package:giveup/components/ActivityHabbitSelector.dart';
import 'package:giveup/components/IconPickerComponent.dart';
import 'package:giveup/components/ListNameDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewListBottomSheetComponent extends StatefulWidget {
  const NewListBottomSheetComponent({super.key});

  @override
  State<NewListBottomSheetComponent> createState() =>
      _NewListBottomSheetComponentState();
}

class _NewListBottomSheetComponentState
    extends State<NewListBottomSheetComponent> {
  final AppControler app = Get.find<AppControler>();

  String _listName = 'New list';
  IconData? _selectedIcon;
  String _selectedOption = 'All';

  @override
  void initState() {
    super.initState();
    _resetToDefault();
    _loadPreferences();
  }

  // Fungsi untuk menyimpan data ke SharedPreferences
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('listName', _listName);
    if (_selectedIcon != null) {
      await prefs.setInt('selectedIcon', _selectedIcon!.codePoint);
    } else {
      await prefs.remove('selectedIcon');
    }
    await prefs.setString('selectedOption', _selectedOption);
  }

  // Fungsi untuk memuat data dari SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _listName = prefs.getString('listName') ?? 'New list';
      int? iconCode = prefs.getInt('selectedIcon');
      _selectedIcon = iconCode != null
          ? IconData(iconCode, fontFamily: 'MaterialIcons')
          : null;
      _selectedOption = prefs.getString('selectedOption') ?? 'All';
    });
  }

  void _updateListName(String newName) {
    setState(() {
      _listName = newName;
    });
  }

  void _showIconPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return IconPickerDialog(
          onIconSelected: (icon) {
            setState(() {
              _selectedIcon = icon;
            });
          },
        );
      },
    );
  }

  void _removeIcon() {
    setState(() {
      _selectedIcon = null;
    });
  }

  void _showActivityHabitSelector() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ActivityHabitSelector(
          onSelectionMade: (String selection) {
            setState(() {
              _selectedOption = selection;
            });
          },
        );
      },
    );
  }

  void _resetToDefault() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('selectedIcon');
    setState(() {
      _listName = 'New list';
      _selectedIcon = null;
      _selectedOption = 'All';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              _listName,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: false,
            leading: null,
            automaticallyImplyLeading: false,
            actions: [
              if (_selectedIcon != null)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _selectedIcon,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ListNameDialog(
                    listNameController: TextEditingController(text: _listName),
                    onListNameSubmitted: _updateListName,
                  );
                },
              );
            },
            child: const Row(
              children: [
                Icon(Icons.edit, color: Colors.black),
                SizedBox(width: 10),
                Text(
                  'List name',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          SizedBox(height: _selectedIcon != null ? 0 : 10),
          InkWell(
            onTap: _showIconPicker,
            child: Row(
              children: [
                const Icon(Icons.image, color: Colors.black),
                const SizedBox(width: 10),
                const Text(
                  'Icon',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                if (_selectedIcon != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: _removeIcon,
                  ),
              ],
            ),
          ),
          SizedBox(height: _selectedIcon != null ? 0 : 10),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            onTap: _showActivityHabitSelector,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.remove_red_eye_outlined, color: Colors.black),
                    SizedBox(width: 10),
                    Text(
                      'Activities',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Text(
                  _selectedOption,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _savePreferences();
                if (_selectedIcon != null) {
                  app.addListUserActivity(
                      _listName, _selectedIcon!, _selectedOption);
                } else {
                  print('error masBro');
                }
                _resetToDefault();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'SAVE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
