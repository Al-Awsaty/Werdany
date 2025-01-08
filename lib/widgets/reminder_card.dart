import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class ReminderCard extends StatelessWidget {
  final int id;
  final String name;
  final String schedule;
  final String purpose;
  final HormoneTrackerService hormoneTrackerService;

  ReminderCard({
    required this.id,
    required this.name,
    required this.schedule,
    required this.purpose,
    required this.hormoneTrackerService,
  });

  void _editReminder(BuildContext context) {
    final nameController = TextEditingController(text: name);
    final scheduleController = TextEditingController(text: schedule);
    final purposeController = TextEditingController(text: purpose);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Reminder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: scheduleController,
                decoration: InputDecoration(labelText: 'Schedule'),
              ),
              TextField(
                controller: purposeController,
                decoration: InputDecoration(labelText: 'Purpose'),
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
                hormoneTrackerService.editReminder(
                  id,
                  nameController.text,
                  scheduleController.text,
                  purposeController.text,
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
            Text('Schedule: $schedule'),
            SizedBox(height: 8),
            Text('Purpose: $purpose'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editReminder(context),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    hormoneTrackerService.deleteReminder(id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
