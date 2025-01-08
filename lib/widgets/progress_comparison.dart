import 'package:flutter/material.dart';
import 'package:your_app/models/body_stats.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class ProgressComparison extends StatelessWidget {
  final List<BodyStats> bodyStats;
  final String beforePhoto;
  final String afterPhoto;
  final HormoneTrackerService hormoneTrackerService;

  ProgressComparison({
    required this.bodyStats,
    required this.beforePhoto,
    required this.afterPhoto,
    required this.hormoneTrackerService,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Progress Comparison', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Text('Before'),
        Image.network(beforePhoto),
        SizedBox(height: 16),
        Text('After'),
        Image.network(afterPhoto),
        SizedBox(height: 16),
        Text('Key Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Weight: ${bodyStats.isNotEmpty ? bodyStats.last.weight : 'N/A'}'),
        Text('Muscle Mass: ${bodyStats.isNotEmpty ? bodyStats.last.muscleMass : 'N/A'}'),
        Text('Fat Percentage: ${bodyStats.isNotEmpty ? bodyStats.last.fatPercentage : 'N/A'}'),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Fetch progress data from hormoneTrackerService
            hormoneTrackerService.getHormones();
          },
          child: Text('Fetch Progress Data'),
        ),
      ],
    );
  }
}
