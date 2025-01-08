import 'package:flutter/material.dart';
import 'package:your_app/services/body_stats_service.dart';
import 'package:your_app/models/body_stats.dart';
import 'package:your_app/widgets/body_stat_chart.dart';
import 'package:your_app/widgets/body_stats_card.dart';

class BodyStatsScreen extends StatefulWidget {
  @override
  _BodyStatsScreenState createState() => _BodyStatsScreenState();
}

class _BodyStatsScreenState extends State<BodyStatsScreen> {
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

  void _showAddBodyStatDialog() {
    final weightController = TextEditingController();
    final muscleMassController = TextEditingController();
    final fatPercentageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Body Stat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: weightController,
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: muscleMassController,
                decoration: InputDecoration(labelText: 'Muscle Mass'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: fatPercentageController,
                decoration: InputDecoration(labelText: 'Fat Percentage'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addBodyStat(
                  BodyStats(
                    weight: double.parse(weightController.text),
                    muscleMass: double.parse(muscleMassController.text),
                    fatPercentage: double.parse(fatPercentageController.text),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditBodyStatDialog(BodyStats stat) {
    final weightController = TextEditingController(text: stat.weight.toString());
    final muscleMassController = TextEditingController(text: stat.muscleMass.toString());
    final fatPercentageController = TextEditingController(text: stat.fatPercentage.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Body Stat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: weightController,
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: muscleMassController,
                decoration: InputDecoration(labelText: 'Muscle Mass'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: fatPercentageController,
                decoration: InputDecoration(labelText: 'Fat Percentage'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _editBodyStat(
                  BodyStats(
                    weight: double.parse(weightController.text),
                    muscleMass: double.parse(muscleMassController.text),
                    fatPercentage: double.parse(fatPercentageController.text),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Stats'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _bodyStats.length,
              itemBuilder: (context, index) {
                return BodyStatsCard(
                  bodyStats: _bodyStats[index],
                  onEdit: _showEditBodyStatDialog,
                  onDelete: _deleteBodyStat,
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _showAddBodyStatDialog,
            child: Text('Manage Body Stats'),
          ),
        ],
      ),
    );
  }
}
