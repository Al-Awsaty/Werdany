import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';
import 'package:your_app/widgets/settings_menu.dart';

class SettingsScreen extends StatelessWidget {
  final HormoneTrackerService hormoneTrackerService = HormoneTrackerService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsMenu(hormoneTrackerService: hormoneTrackerService),
    );
  }
}
