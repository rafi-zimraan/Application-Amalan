import 'package:flutter/material.dart';

class NotificationSelectionWidget extends StatefulWidget {
  const NotificationSelectionWidget({super.key});

  @override
  _NotificationSelectionWidgetState createState() =>
      _NotificationSelectionWidgetState();
}

class _NotificationSelectionWidgetState
    extends State<NotificationSelectionWidget> {
  bool _isDoNotDisturbEnabled = false;
  final bool _isPlayReminderSound = false;
  final TextEditingController _durationController = TextEditingController();

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
          'Pilih Jenis Notifikasi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue),
                  const SizedBox(width: 8.0),
                  Flexible(
                    child: Text(
                      'Pelajari lebih lanjut tentang Mode Jangan Ganggu dan cara kerjanya.',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      text:
                          'Aktifkan Mode Jangan Ganggu Saat Waktu ibadah tiba, ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              'mode ini dapat mematikan suara, menonaktifkan getaran, dan memblokir panggilan.',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 9.0),
                Switch(
                  value: _isDoNotDisturbEnabled,
                  onChanged: (bool? value) {
                    setState(() {
                      _isDoNotDisturbEnabled = value ?? false;
                    });
                  },
                  activeColor: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 25),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: _durationController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Durasi Mode Jangan Ganggu',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text(
                    'Menit',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'MODE SLALU BUNYIKAN SUARA PENGINGAT',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Bunyikan suara pengingat saat waktu ibadah tiba walaupun hp dalam mode senyap.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Switch(
                  value: _isDoNotDisturbEnabled,
                  onChanged: (bool? value) {
                    setState(() {
                      _isDoNotDisturbEnabled = value ?? false;
                    });
                  },
                  activeColor: Colors.blue,
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
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
    );
  }
}
