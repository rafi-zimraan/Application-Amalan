import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giveup/Controller/App_controller.dart';
import 'package:giveup/screens/AudioSelectionWidget.dart';
import 'package:giveup/screens/IconSelectionWidget.dart';
import 'package:giveup/screens/NotificationSelectionWidget.dart';
import 'package:giveup/screens/ReminderSelectionWidget.dart';

class DetailKelolaScreen extends StatelessWidget {
  final String title;
  final String feature;

  const DetailKelolaScreen({
    super.key,
    required this.title,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    final AppControler controller = Get.find<AppControler>();

    Widget featureWidget;

    switch (feature) {
      case 'icon':
        featureWidget = IconSelectionWidget(title: title);
        break;
      case 'audio':
        featureWidget = const AudioSelectionWidget();
        break;
      case 'notification':
        featureWidget = const NotificationSelectionWidget();
        break;
      case 'reminder':
        featureWidget = const ReminderSelectionWidget();
        break;
      default:
        featureWidget = const Center(child: Text('No feature available'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: featureWidget,
    );
  }
}
