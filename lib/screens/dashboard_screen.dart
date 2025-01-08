import 'package:flutter/material.dart';
import 'package:your_app/services/body_stats_service.dart';
import 'package:your_app/services/hormone_tracker_service.dart';
import 'package:your_app/models/body_stats.dart';
import 'package:your_app/widgets/photo_comparison_widget.dart';
import 'package:your_app/widgets/hormone_card.dart';
import 'package:your_app/widgets/progress_visualization.dart';
import 'package:your_app/screens/hormone_schedule_screen.dart';
import 'package:your_app/screens/training_plan_screen.dart';
import 'package:your_app/screens/nutrition_plan_screen.dart';
import 'package:your_app/screens/progress_photos_screen.dart';
import 'package:your_app/screens/body_stats_screen.dart';
import 'package:your_app/screens/reminders_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<BodyStats> _bodyStats = [];
  List<Map<String, dynamic>> _hormones = [];
  final BodyStatsService _bodyStatsService = BodyStatsService();
  final HormoneTrackerService _hormoneTrackerService = HormoneTrackerService();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final bodyStats = await _bodyStatsService.getBodyStats();
    final hormones = await _hormoneTrackerService.getHormones();
    setState(() {
      _bodyStats = bodyStats;
      _hormones = hormones;
    });
  }

  void _navigateToScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView(
        children: [
          Card(
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
                  Text('Weight: ${_bodyStats.isNotEmpty ? _bodyStats.last.weight : 'N/A'}'),
                  Text('Muscle Mass: ${_bodyStats.isNotEmpty ? _bodyStats.last.muscleMass : 'N/A'}'),
                  Text('Fat Percentage: ${_bodyStats.isNotEmpty ? _bodyStats.last.fatPercentage : 'N/A'}'),
                  SizedBox(height: 16),
                  ProgressVisualization(bodyStats: _bodyStats),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Progress Photos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  PhotoComparisonWidget(
                    beforePhoto: 'https://example.com/before.jpg',
                    afterPhoto: 'https://example.com/after.jpg',
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming Training Schedules and Hormone Dosages',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  ..._hormones.map((hormone) => HormoneCard(
                        id: hormone['id'],
                        name: hormone['name'],
                        dosage: hormone['dosage'],
                        schedule: hormone['schedule'],
                        purpose: hormone['purpose'],
                        hormoneTrackerService: _hormoneTrackerService,
                      )),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Navigation',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _navigateToScreen(HormoneScheduleScreen()),
                    child: Text('Hormone Schedule'),
                  ),
                  ElevatedButton(
                    onPressed: () => _navigateToScreen(TrainingPlanScreen()),
                    child: Text('Training Plan'),
                  ),
                  ElevatedButton(
                    onPressed: () => _navigateToScreen(NutritionPlanScreen()),
                    child: Text('Nutrition Plan'),
                  ),
                  ElevatedButton(
                    onPressed: () => _navigateToScreen(ProgressPhotosScreen()),
                    child: Text('Progress Photos'),
                  ),
                  ElevatedButton(
                    onPressed: () => _navigateToScreen(BodyStatsScreen()),
                    child: Text('Body Stats'),
                  ),
                  ElevatedButton(
                    onPressed: () => _navigateToScreen(RemindersScreen()),
                    child: Text('Reminders'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
