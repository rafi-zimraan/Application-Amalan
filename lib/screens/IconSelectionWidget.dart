import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IconSelectionWidget extends StatefulWidget {
  final String title;
  const IconSelectionWidget({super.key, required this.title});

  @override
  _IconSelectionWidgetState createState() => _IconSelectionWidgetState();
}

class _IconSelectionWidgetState extends State<IconSelectionWidget> {
  int? selectedIconIndex;
  String? selectedIconPath;

  // final List<IconData> icons = [
  //   Icons.mosque,
  //   Icons.star,
  //   Icons.access_time,
  //   Icons.people,
  //   Icons.church,
  //   Icons.directions_run,
  //   Icons.local_cafe,
  //   Icons.event,
  //   Icons.school,
  // ];

  final List<String> icons = [
    'lib/assets/icons/childMasjid.png',
    'lib/assets/icons/church.png',
    'lib/assets/icons/bigMasjid.png',
    'lib/assets/icons/borobudur.png',
    'lib/assets/icons/istanaMasjid.png',
    'lib/assets/icons/masjid.png',
    'lib/assets/icons/buddha.png',
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedIcon();
  }

  Future<void> _loadSelectedIcon() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? index = prefs.getInt('${widget.title}_iconIndex');
    String? path = prefs.getString('${widget.title}_iconPath');
    setState(() {
      selectedIconIndex = index;
      selectedIconPath = path;
    });
  }

  void _onIconTap(int index) {
    setState(() {
      selectedIconIndex = index;
      selectedIconPath = icons[index];
    });
  }

  Future<void> _saveSelectedIcon() async {
    if (selectedIconIndex != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('${widget.title}_iconIndex', selectedIconIndex!);
      await prefs.setString('${widget.title}_iconPath', selectedIconPath ?? '');
      Navigator.pop(context, selectedIconPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: icons.length,
              itemBuilder: (context, index) {
                bool isSelectedBox = selectedIconIndex == index;
                return GestureDetector(
                  onTap: () => _onIconTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedIconIndex == index
                            ? Colors.blue
                            : Colors.grey,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Image.asset(
                        icons[index],
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _saveSelectedIcon,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
