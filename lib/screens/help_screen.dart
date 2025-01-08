import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final HormoneTrackerService _hormoneTrackerService = HormoneTrackerService();
  List<Map<String, dynamic>> _helpResources = [];

  @override
  void initState() {
    super.initState();
    _loadHelpResources();
  }

  Future<void> _loadHelpResources() async {
    final resources = await _hormoneTrackerService.getHelpResources();
    setState(() {
      _helpResources = resources;
    });
  }

  void _searchHelpResources(String query) {
    final filteredResources = _helpResources.where((resource) {
      final resourceName = resource['name'].toLowerCase();
      final searchQuery = query.toLowerCase();
      return resourceName.contains(searchQuery);
    }).toList();

    setState(() {
      _helpResources = filteredResources;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Help Resources',
                border: OutlineInputBorder(),
              ),
              onChanged: _searchHelpResources,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _helpResources.length,
              itemBuilder: (context, index) {
                final resource = _helpResources[index];
                return ListTile(
                  title: Text(resource['name']),
                  subtitle: Text(resource['description']),
                  onTap: () {
                    // Open the help resource link
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
