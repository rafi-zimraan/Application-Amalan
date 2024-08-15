import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveup/Controller/App_controller.dart';
import 'package:giveup/components/Google_login_profile_component.dart';
import 'package:giveup/components/Setting_profile_component.dart';
import 'package:giveup/components/Switch_mode_profile_component.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final bool _isSafarMode = false;
  final bool _isHaidMode = false;

  void _showInfoDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppControler app = Get.find();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.person, size: 50),
            const SizedBox(height: 10),
            GoogleLoginProfileComponent(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Dalam Tahap Pengembangan"),
                      content: const Text("Minta doanya agar dipermudah"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 5),
            const Divider(color: Colors.grey),
            // const SizedBox(height: 10),
            // SwitchModeProfileComponent(
            //   iconPath: 'lib/assets/icons/plane.png',
            //   title: "Mode Safar",
            //   info:
            //       "Mode ini direkomendasikan bagi Anda yang sedang melakukan safar. Dengan mengaktifkan mode ini waktu ibadah akan disesuaikan dengan lokasi anda",
            //   value: app.safarMode.value,
            //   onChanged: (value) {
            //     setState(() {
            //       app.toggleModsafar(value);
            //     });
            //   },
            //   onInfoPressed: () {
            //     _showInfoDialog(
            //       "Mode Safar",
            //       "Mode ini direkomendasikan bagi Anda yang sedang melakukan safar. Dengan mengaktifkan mode ini waktu ibadah akan disesuaikan dengan lokasi anda",
            //     );
            //   },
            // ),
            // const SizedBox(height: 15),
            SwitchModeProfileComponent(
              iconPath: 'lib/assets/icons/water.png',
              title: "Mode Haid",
              info:
                  "Mode ini direkomendasikan bagi Muslimah yang sedang haid. Dengan mengaktifkan mode ini, daftar ibadah akan disesuaikan dengan ibadah yang dilakukan dalam keadaan haid ",
              value: app.haidMode.value,
              onChanged: (value) {
                setState(() {
                  app.toggleModeHaid(value);
                });
              },
              onInfoPressed: () {
                _showInfoDialog(
                  "Mode Haid",
                  "Mode ini direkomendasikan bagi Muslimah yang sedang haid. Dengan mengaktifkan mode ini, daftar ibadah akan disesuaikan dengan ibadah yang dilakukan dalam keadaan haid ",
                );
              },
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "PENGATURAN APLIKASI",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 25),
            SettingProfileComponent(
              iconPath: 'lib/assets/icons/sunrise.png',
              title: "Perhitungan Shalat & Hijriah",
              subtitle: "Metode, koreksi, hijriah, angka",
              onPressed: () {},
            ),
            const SizedBox(height: 40),
            SettingProfileComponent(
              iconPath: 'lib/assets/icons/bell.png',
              title: "Notifikasi",
              subtitle:
                  "Mode jangan ganggu, \nselalu bunyikan suara, tampilan visual",
              onPressed: () {},
            ),
            const SizedBox(height: 40),
            SettingProfileComponent(
              iconPath: 'lib/assets/icons/location.png',
              title: "Lokasi",
              subtitle: "Lokasi saat ini, ketinggian",
              onPressed: () {},
            ),
            const SizedBox(height: 40),
            SettingProfileComponent(
              iconPath: 'lib/assets/icons/megaphone.png',
              title: "Adzan Tidak Berbunyi",
              subtitle: "Optimasi suara pada pengingat",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
