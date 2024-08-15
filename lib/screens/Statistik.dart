import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveup/Controller/App_controller.dart';
import 'package:giveup/screens/Kalender.dart';
import 'package:giveup/screens/StatistikPageContent.dart';

class Statistik extends StatefulWidget {
  final int initialTabIndex;
  const Statistik({super.key, required this.initialTabIndex});

  @override
  _StatistikState createState() => _StatistikState();
}

class _StatistikState extends State<Statistik>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AppControler app = Get.find();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        app.initialTabIndex.value = _tabController.index;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tabController.index = widget.initialTabIndex;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Calendar'),
                Tab(text: 'Statistics'),
              ],
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Center(child: Kalender()),
                  Center(child: StatistikPageContent()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
