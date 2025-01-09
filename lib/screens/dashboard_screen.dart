import 'package:flutter/material.dart';
import 'package:your_app/services/body_stats_service.dart';
import 'package:your_app/services/hormone_tracker_service.dart';
import 'package:your_app/models/body_stats.dart';
import 'package:your_app/widgets/photo_comparison_widget.dart';
import 'package:your_app/widgets/hormone_card.dart';
import 'package:your_app/widgets/body_stat_chart.dart';

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
                  BodyStatChart(bodyStats: _bodyStats),
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
                  // Add logic to display recent progress photos
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
                        name: hormone['name'],
                        dosage: hormone['dosage'],
                        schedule: hormone['schedule'],
                        purpose: hormone['purpose'],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Body Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Diet Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Hormone Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Progress Photos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Trainer Dashboard',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          // Add navigation logic here
        },
      ),
    );
  }
}
