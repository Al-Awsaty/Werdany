import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class AboutInfo extends StatelessWidget {
  final HormoneTrackerService hormoneTrackerService = HormoneTrackerService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: hormoneTrackerService.getAboutData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final aboutData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  aboutData['appName'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(aboutData['description']),
                SizedBox(height: 16),
                Text(
                  'Developers:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...aboutData['developers'].map<Widget>((developer) {
                  return ListTile(
                    title: Text(developer['name']),
                    subtitle: Text(developer['email']),
                  );
                }).toList(),
              ],
            ),
          );
        }
      },
    );
  }
}
