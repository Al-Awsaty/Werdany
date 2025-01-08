import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class AIRecommendationsScreen extends StatefulWidget {
  @override
  _AIRecommendationsScreenState createState() => _AIRecommendationsScreenState();
}

class _AIRecommendationsScreenState extends State<AIRecommendationsScreen> {
  final HormoneTrackerService _hormoneTrackerService = HormoneTrackerService();
  List<Map<String, dynamic>> _recommendations = [];

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
  }

  Future<void> _loadRecommendations() async {
    final recommendations = await _hormoneTrackerService.getAIRecommendations();
    setState(() {
      _recommendations = recommendations;
    });
  }

  void _acceptRecommendation(int id) async {
    await _hormoneTrackerService.acceptAIRecommendation(id);
    _loadRecommendations();
  }

  void _rejectRecommendation(int id) async {
    await _hormoneTrackerService.rejectAIRecommendation(id);
    _loadRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Recommendations'),
      ),
      body: ListView.builder(
        itemCount: _recommendations.length,
        itemBuilder: (context, index) {
          final recommendation = _recommendations[index];
          return Card(
            child: ListTile(
              title: Text(recommendation['title']),
              subtitle: Text(recommendation['description']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () => _acceptRecommendation(recommendation['id']),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => _rejectRecommendation(recommendation['id']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
