import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class SettingsOption extends StatelessWidget {
  final String name;
  final String value;
  final String description;
  final HormoneTrackerService hormoneTrackerService;

  SettingsOption({
    required this.name,
    required this.value,
    required this.description,
    required this.hormoneTrackerService,
  });

  void _editSetting(BuildContext context) {
    final valueController = TextEditingController(text: value);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Setting'),
          content: TextField(
            controller: valueController,
            decoration: InputDecoration(labelText: 'Value'),
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
                hormoneTrackerService.updateSetting(name, valueController.text);
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
            Text('Value: $value'),
            SizedBox(height: 8),
            Text('Description: $description'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editSetting(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
