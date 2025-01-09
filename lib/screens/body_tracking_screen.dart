import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:your_app/services/body_stats_service.dart';
import 'package:your_app/models/body_stats.dart';
import 'package:your_app/widgets/body_stat_chart.dart';

class BodyTrackingScreen extends StatefulWidget {
  @override
  _BodyTrackingScreenState createState() => _BodyTrackingScreenState();
}

class _BodyTrackingScreenState extends State<BodyTrackingScreen> {
  List<BodyStats> _bodyStats = [];
  final BodyStatsService _bodyStatsService = BodyStatsService();

  @override
  void initState() {
    super.initState();
    _loadBodyStats();
  }

  Future<void> _loadBodyStats() async {
    final stats = await _bodyStatsService.getBodyStats();
    setState(() {
      _bodyStats = stats;
    });
  }

  void _addBodyStat(BodyStats stat) async {
    await _bodyStatsService.addBodyStat(stat);
    _loadBodyStats();
  }

  void _editBodyStat(BodyStats stat) async {
    await _bodyStatsService.updateBodyStat(stat);
    _loadBodyStats();
  }

  void _deleteBodyStat(int id) async {
    await _bodyStatsService.deleteBodyStat(id);
    _loadBodyStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Tracking'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BodyStatChart(bodyStats: _bodyStats),
          ),
          ElevatedButton(
            onPressed: () {
              // Add logic to add, edit, and delete body stats
            },
            child: Text('Manage Body Stats'),
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
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          // Add navigation logic here
        },
      ),
    );
  }
}
