import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioSelectionWidget extends StatefulWidget {
  const AudioSelectionWidget({super.key});

  @override
  State<AudioSelectionWidget> createState() => _AudioSelectionWidgetState();
}

class _AudioSelectionWidgetState extends State<AudioSelectionWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<bool> isPlaying = [false, false, false, false, false];
  List<bool> isCheckboxChecked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedAudio();
  }

  Future<void> _saveSelectedAudio(String audioName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_audio', audioName);
  }

  Future<void> _loadSelectedAudio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedAudio = prefs.getString('selected_audio');

    if (selectedAudio != null) {
      setState(() {
        for (int i = 0; i < isCheckboxChecked.length; i++) {
          isCheckboxChecked[i] = false;
        }

        switch (selectedAudio) {
          case 'Tanpa Audio':
            isCheckboxChecked[0] = true;
            break;
          case 'Getar aja':
            isCheckboxChecked[1] = true;
            break;
          case 'Adzan Ufuk':
            isCheckboxChecked[2] = true;
            break;
          case 'Takbir':
            isCheckboxChecked[3] = true;
            break;
          case 'alaram':
            isCheckboxChecked[4] = true;
            break;
          case 'jawa':
            isCheckboxChecked[5] = true;
            break;
          case 'Jepang':
            isCheckboxChecked[6] = true;
            break;
        }
      });
    }
  }

  void _onCheckboxChanged(int index, String audioName) {
    setState(() {
      for (int i = 0; i < isCheckboxChecked.length; i++) {
        isCheckboxChecked[i] = false;
      }
      isCheckboxChecked[index] = true;
    });
    _saveSelectedAudio(audioName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Audio Pengingat',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            buildRow(
              icon: Icons.volume_off,
              text: 'Tanpa Audio',
              isChecked: isCheckboxChecked[0],
              onChanged: (bool? newValue) {
                if (newValue == true) {
                  _onCheckboxChanged(0, 'Tanpa Audio');
                }
              },
            ),
            const SizedBox(height: 10),
            buildRow(
              icon: Icons.vibration,
              text: 'Getar aja',
              isChecked: isCheckboxChecked[1],
              onChanged: (bool? newValue) {
                if (newValue == true) {
                  _onCheckboxChanged(1, 'Getar aja');
                }
              },
            ),
            const SizedBox(height: 10),
            buildRow(
              icon: isPlaying[0]
                  ? Icons.pause_circle_outline_outlined
                  : Icons.play_circle_filled,
              text: 'Adzan Ufuk',
              isChecked: isCheckboxChecked[2],
              onChanged: (bool? newValue) {
                if (newValue == true) {
                  _onCheckboxChanged(2, 'Adzan Ufuk');
                }
              },
              onIconPressed: () {
                setState(() {
                  isPlaying[0] = !isPlaying[0];
                });
                if (isPlaying[0]) {
                  _audioPlayer.play(AssetSource('adzan.mp3'));
                } else {
                  _audioPlayer.stop();
                }
              },
            ),
            const SizedBox(height: 10),
            buildRow(
              icon: isPlaying[1]
                  ? Icons.pause_circle_outline_outlined
                  : Icons.play_circle_filled,
              text: 'Takbir',
              isChecked: isCheckboxChecked[3],
              onChanged: (bool? newValue) {
                if (newValue == true) {
                  _onCheckboxChanged(3, 'Takbir');
                }
              },
              onIconPressed: () {
                setState(() {
                  isPlaying[1] = !isPlaying[1];
                });
                if (isPlaying[1]) {
                  _audioPlayer.play(AssetSource('adzanSubuh.mp3'));
                } else {
                  _audioPlayer.stop();
                }
              },
            ),
            const SizedBox(height: 10),
            buildRow(
              icon: isPlaying[2]
                  ? Icons.pause_circle_outline_outlined
                  : Icons.play_circle_filled,
              text: 'alaram',
              isChecked: isCheckboxChecked[4],
              onChanged: (bool? newValue) {
                if (newValue == true) {
                  _onCheckboxChanged(4, 'alaram');
                }
              },
              onIconPressed: () {
                setState(() {
                  isPlaying[2] = !isPlaying[2];
                });
                if (isPlaying[2]) {
                  _audioPlayer.play(AssetSource('alaram.mp3'));
                } else {
                  _audioPlayer.stop();
                }
              },
            ),
            const SizedBox(height: 10),
            buildRow(
              icon: isPlaying[3]
                  ? Icons.pause_circle_outline_outlined
                  : Icons.play_circle_filled,
              text: 'jawa',
              isChecked: isCheckboxChecked[5],
              onChanged: (bool? newValue) {
                if (newValue == true) {
                  _onCheckboxChanged(5, 'jawa');
                }
              },
              onIconPressed: () {
                setState(() {
                  isPlaying[3] = !isPlaying[3];
                });
                if (isPlaying[3]) {
                  _audioPlayer.play(AssetSource('javaMessage.mp3'));
                } else {
                  _audioPlayer.stop();
                }
              },
            ),
            const SizedBox(height: 10),
            buildRow(
              icon: isPlaying[4]
                  ? Icons.pause_circle_outline_outlined
                  : Icons.play_circle_filled,
              text: 'Jepang',
              isChecked: isCheckboxChecked[6],
              onChanged: (bool? newValue) {
                if (newValue == true) {
                  _onCheckboxChanged(6, 'Jepang');
                }
              },
              onIconPressed: () {
                setState(() {
                  isPlaying[4] = !isPlaying[4];
                });
                if (isPlaying[4]) {
                  _audioPlayer.play(AssetSource('jepangMessage.mp3'));
                } else {
                  _audioPlayer.stop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow({
    required IconData icon,
    required String text,
    required bool isChecked,
    required ValueChanged<bool?> onChanged,
    VoidCallback? onIconPressed,
    Color? iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon, size: 35, color: iconColor ?? Colors.black),
          onPressed: onIconPressed,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
            shape: const CircleBorder(),
            value: isChecked,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
