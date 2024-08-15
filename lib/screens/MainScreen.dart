import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveup/Controller/App_controller.dart';
import 'package:giveup/screens/Home.dart';
import 'package:giveup/screens/Profile.dart';
import 'package:giveup/screens/Sholat.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final AppControler app = Get.find();

  static List<Widget> _widgetBodyItems(int initialTabIndex) => [
        const Home(),
        const Sholat(),
        // Statistik(initialTabIndex: initialTabIndex),
        const Profile(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: app.activeTab.value,
          children: _widgetBodyItems(app.initialTabIndex.value),
        ),
      ),
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.mosque_outlined),
                label: "Today",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time),
                label: "Sholat",
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.timelapse),
              //   label: "Statistik",
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
            currentIndex: app.activeTab.value,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: (index) {
              app.activeTab.value = index;
              if (index != 2) {
                app.initialTabIndex.value = 0;
              }
            },
          );
        },
      ),
    );
  }
}
