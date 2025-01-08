import 'package:flutter/material.dart';
import 'package:your_app/models/training_plan.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class TrainingPlanCard extends StatelessWidget {
  final TrainingPlan trainingPlan;
  final Function(TrainingPlan) onEdit;
  final Function(int) onDelete;
  final HormoneTrackerService hormoneTrackerService;

  TrainingPlanCard({
    required this.trainingPlan,
    required this.onEdit,
    required this.onDelete,
    required this.hormoneTrackerService,
  });

  void _editTrainingPlan(BuildContext context) {
    final nameController = TextEditingController(text: trainingPlan.name);
    final scheduleController = TextEditingController(text: trainingPlan.schedule);
    final purposeController = TextEditingController(text: trainingPlan.purpose);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Training Plan'),
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
                hormoneTrackerService.editTrainingPlan(
                  trainingPlan.id,
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
              trainingPlan.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Schedule: ${trainingPlan.schedule}'),
            SizedBox(height: 8),
            Text('Purpose: ${trainingPlan.purpose}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editTrainingPlan(context),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onDelete(trainingPlan.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
