import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';
import 'package:your_app/widgets/training_plan_card.dart';

class TrainingPlanScreen extends StatefulWidget {
  @override
  _TrainingPlanScreenState createState() => _TrainingPlanScreenState();
}

class _TrainingPlanScreenState extends State<TrainingPlanScreen> {
  List<TrainingPlan> _trainingPlans = [];
  final HormoneTrackerService _hormoneTrackerService = HormoneTrackerService();

  @override
  void initState() {
    super.initState();
    _loadTrainingPlans();
  }

  Future<void> _loadTrainingPlans() async {
    final plans = await _hormoneTrackerService.getTrainingPlans();
    setState(() {
      _trainingPlans = plans;
    });
  }

  void _addTrainingPlan(TrainingPlan plan) async {
    await _hormoneTrackerService.addTrainingPlan(plan);
    _loadTrainingPlans();
  }

  void _editTrainingPlan(TrainingPlan plan) async {
    await _hormoneTrackerService.updateTrainingPlan(plan);
    _loadTrainingPlans();
  }

  void _deleteTrainingPlan(int id) async {
    await _hormoneTrackerService.deleteTrainingPlan(id);
    _loadTrainingPlans();
  }

  void _showAddTrainingPlanDialog() {
    final nameController = TextEditingController();
    final scheduleController = TextEditingController();
    final purposeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Training Plan'),
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
                _addTrainingPlan(
                  TrainingPlan(
                    id: 0,
                    name: nameController.text,
                    schedule: scheduleController.text,
                    purpose: purposeController.text,
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

  void _showEditTrainingPlanDialog(TrainingPlan plan) {
    final nameController = TextEditingController(text: plan.name);
    final scheduleController = TextEditingController(text: plan.schedule);
    final purposeController = TextEditingController(text: plan.purpose);

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
                _editTrainingPlan(
                  TrainingPlan(
                    id: plan.id,
                    name: nameController.text,
                    schedule: scheduleController.text,
                    purpose: purposeController.text,
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
        title: Text('Training Plans'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _trainingPlans.length,
              itemBuilder: (context, index) {
                return TrainingPlanCard(
                  trainingPlan: _trainingPlans[index],
                  onEdit: _editTrainingPlan,
                  onDelete: _deleteTrainingPlan,
                  hormoneTrackerService: _hormoneTrackerService,
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _showAddTrainingPlanDialog,
            child: Text('Manage Training Plans'),
          ),
        ],
      ),
    );
  }
}
