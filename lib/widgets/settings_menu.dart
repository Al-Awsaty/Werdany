import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class SettingsMenu extends StatelessWidget {
  final HormoneTrackerService hormoneTrackerService;

  SettingsMenu({required this.hormoneTrackerService});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Notification Settings'),
          onTap: () {
            // Navigate to notification settings screen
          },
        ),
        ListTile(
          title: Text('Profile Settings'),
          onTap: () {
            // Navigate to profile settings screen
          },
        ),
        ListTile(
          title: Text('App Theme'),
          onTap: () {
            // Navigate to app theme settings screen
          },
        ),
        ListTile(
          title: Text('Privacy Policy'),
          onTap: () {
            // Navigate to privacy policy screen
          },
        ),
        ListTile(
          title: Text('Terms of Service'),
          onTap: () {
            // Navigate to terms of service screen
          },
        ),
        ListTile(
          title: Text('Logout'),
          onTap: () {
            // Handle logout
          },
        ),
      ],
    );
  }
}
