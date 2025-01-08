import 'package:flutter/material.dart';
import 'package:your_app/models/body_stats.dart';
import 'package:your_app/services/body_stats_service.dart';

class BodyStatsCard extends StatelessWidget {
  final BodyStats bodyStats;
  final Function(BodyStats) onEdit;
  final Function(int) onDelete;

  BodyStatsCard({
    required this.bodyStats,
    required this.onEdit,
    required this.onDelete,
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
              'Body Stats',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Weight: ${bodyStats.weight} kg'),
            SizedBox(height: 8),
            Text('Muscle Mass: ${bodyStats.muscleMass} kg'),
            SizedBox(height: 8),
            Text('Fat Percentage: ${bodyStats.fatPercentage} %'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => onEdit(bodyStats),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onDelete(bodyStats.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
