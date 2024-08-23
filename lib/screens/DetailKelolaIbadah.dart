import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveup/Controller/App_controller.dart';
import 'package:giveup/screens/AudioSelectionWidget.dart';
import 'package:giveup/screens/IconSelectionWidget.dart';
import 'package:giveup/screens/NotificationSelectionWidget.dart';
import 'package:giveup/screens/ReminderSelectionWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailKelolaIbadah extends StatefulWidget {
  final String title;
  final String category;
  final bool bolehDilakukanSaatHaid;
  final ValueChanged<bool> onBolehDilakukanSaatHaidChanged;
  final Function(String) onSaveIcon;

  const DetailKelolaIbadah({
    super.key,
    required this.title,
    required this.category,
    required this.bolehDilakukanSaatHaid,
    required this.onBolehDilakukanSaatHaidChanged,
    required this.onSaveIcon,
  });

  @override
  _DetailKelolaIbadahState createState() => _DetailKelolaIbadahState();
}

class _DetailKelolaIbadahState extends State<DetailKelolaIbadah> {
  final AppControler controller = Get.find<AppControler>();
  late String selectedIcon;
  String selectedAudio = 'Bip';

  @override
  void initState() {
    super.initState();
    selectedIcon = controller.getIcon(widget.title);
    controller.setRepeatText(widget.title);
    _loadSelectedIcon();
    _loadSelectedAudio();
  }

  Future<void> _loadSelectedAudio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? audioName = prefs.getString('selected_audio');
    if (audioName != null) {
      setState(() {
        selectedAudio = audioName;
      });
    }
  }

  Future<void> _loadSelectedIcon() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? iconPath = prefs.getString('${widget.title}_iconPath');
    if (iconPath != null) {
      setState(() {
        selectedIcon = iconPath;
      });
    }
  }

  Future<void> _saveSelectedIcon() async {
    await controller.updateIcon(widget.title, selectedIcon);
    widget.onSaveIcon(selectedIcon);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('${widget.title}_iconPath', selectedIcon);
  }

  void _navigateToDetailScreen(
      BuildContext context, String label, String feature) async {
    String? selectedIconPath;
    switch (feature) {
      case 'icon':
        selectedIconPath = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IconSelectionWidget(title: widget.title),
            )) as String?;
        break;
      case 'reminder':
        selectedIconPath = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ReminderSelectionWidget(),
            )) as String?;
        break;
      case 'audio':
        selectedIconPath = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AudioSelectionWidget(),
            )) as String?;
        break;
      case 'notification':
        selectedIconPath = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificationSelectionWidget(),
            )) as String?;
        break;
      default:
        print('No feature selected');
    }

    if (selectedIconPath != null) {
      setState(() {
        selectedIcon = selectedIconPath!;
      });
      _saveSelectedIcon();
    } else {
      print('No icon selected');
    }
  }

  Widget _buildRow(BuildContext context, String label, String value,
      dynamic icon, Color iconColor,
      {bool isTappable = false, String? feature}) {
    return Column(
      children: [
        GestureDetector(
          onTap: isTappable
              ? () => _navigateToDetailScreen(context, label, feature!)
              : null,
          child: Row(
            children: [
              if (icon is IconData)
                Icon(icon, size: 30, color: iconColor)
              else if (icon is String)
                Image.asset(icon, width: 30, height: 30),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: iconColor,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: iconColor.withOpacity(0.54),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios, size: 30, color: iconColor),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail ${widget.title}'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0).copyWith(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow(context, 'Nama Ibadah', widget.title,
                    Icons.text_fields, Colors.grey),
                _buildRow(context, 'Kategori', widget.category, Icons.category,
                    Colors.grey),
                _buildRow(
                    context,
                    'Icon',
                    controller.iconDescriptions[selectedIcon] ?? '',
                    selectedIcon,
                    Colors.black,
                    isTappable: true,
                    feature: 'icon'),
                _buildRow(
                    context, 'Mulai', '-', Icons.calendar_today, Colors.grey),
                _buildRow(context, 'Berakhir', '-', Icons.calendar_today,
                    Colors.grey),
                Obx(() {
                  return _buildRow(context, 'Ulangi',
                      controller.repeatText.value, Icons.repeat, Colors.grey);
                }),
                _buildRow(context, 'Target', '1 Kali', Icons.track_changes,
                    Colors.grey),
                _buildRow(context, 'Ingatkan Pada', 'Sesuai Jadwal',
                    Icons.timer, Colors.black,
                    isTappable: true, feature: 'reminder'),
                _buildRow(context, 'Audio Pengingat', selectedAudio,
                    Icons.multitrack_audio_sharp, Colors.black,
                    isTappable: true, feature: 'audio'),
                _buildRow(context, 'Jenis Notifikasi', 'Banner',
                    Icons.notifications_active_rounded, Colors.black,
                    isTappable: true, feature: 'notification'),
                Row(
                  children: [
                    const Icon(Icons.water_drop, size: 30, color: Colors.grey),
                    const SizedBox(width: 15),
                    const Text(
                      'Boleh Dilakukan saat Haid',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    const Spacer(),
                    Switch(
                      value: widget.bolehDilakukanSaatHaid,
                      onChanged: widget.onBolehDilakukanSaatHaidChanged,
                    ),
                  ],
                ),
              ],
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
                onPressed: () {
                  _saveSelectedIcon();
                  Navigator.pop(context);
                },
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
