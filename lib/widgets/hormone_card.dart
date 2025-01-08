import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class HormoneCard extends StatelessWidget {
  final int id;
  final String name;
  final double dosage;
  final String schedule;
  final String purpose;
  final HormoneTrackerService hormoneTrackerService;

  HormoneCard({
    required this.id,
    required this.name,
    required this.dosage,
    required this.schedule,
    required this.purpose,
    required this.hormoneTrackerService,
  });

  void _editHormone(BuildContext context) {
    final nameController = TextEditingController(text: name);
    final dosageController = TextEditingController(text: dosage.toString());
    final scheduleController = TextEditingController(text: schedule);
    final purposeController = TextEditingController(text: purpose);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Hormone'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: dosageController,
                decoration: InputDecoration(labelText: 'Dosage'),
                keyboardType: TextInputType.number,
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
                hormoneTrackerService.editHormone(
                  id,
                  nameController.text,
                  double.parse(dosageController.text),
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
            Text('Dosage: $dosage'),
            SizedBox(height: 8),
            Text('Schedule: $schedule'),
            SizedBox(height: 8),
            Text('Purpose: $purpose'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editHormone(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
