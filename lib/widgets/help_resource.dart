import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class HelpResource extends StatelessWidget {
  final String name;
  final String description;
  final String link;
  final HormoneTrackerService hormoneTrackerService;

  HelpResource({
    required this.name,
    required this.description,
    required this.link,
    required this.hormoneTrackerService,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // Open the help resource link
              },
              child: Text('Learn More'),
            ),
          ],
        ),
      ),
    );
  }
}
