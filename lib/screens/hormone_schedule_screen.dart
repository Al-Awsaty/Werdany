import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';
import 'package:your_app/widgets/hormone_card.dart';
import 'package:your_app/models/hormone.dart';
import 'package:your_app/services/notification_service.dart';

class HormoneScheduleScreen extends StatefulWidget {
  @override
  _HormoneScheduleScreenState createState() => _HormoneScheduleScreenState();
}

class _HormoneScheduleScreenState extends State<HormoneScheduleScreen> {
  final HormoneTrackerService _hormoneTrackerService = HormoneTrackerService();
  final NotificationService _notificationService = NotificationService();
  List<Hormone> _hormones = [];

  @override
  void initState() {
    super.initState();
    _loadHormones();
  }

  Future<void> _loadHormones() async {
    final hormones = await _hormoneTrackerService.getHormones();
    setState(() {
      _hormones = hormones.map((hormone) => Hormone.fromJson(hormone)).toList();
    });
  }

  Future<void> _addHormone(String name, double dosage, DateTime schedule, String purpose) async {
    final hormone = Hormone(
      id: 0,
      name: name,
      dosage: dosage,
      schedule: schedule,
      purpose: purpose,
    );
    await _hormoneTrackerService.addHormone(hormone);
    _loadHormones();
    _scheduleNotification(hormone);
  }

  Future<void> _editHormone(int id, String name, double dosage, DateTime schedule, String purpose) async {
    final hormone = Hormone(
      id: id,
      name: name,
      dosage: dosage,
      schedule: schedule,
      purpose: purpose,
    );
    await _hormoneTrackerService.editHormone(hormone);
    _loadHormones();
    _scheduleNotification(hormone);
  }

  Future<void> _deleteHormone(int id) async {
    await _hormoneTrackerService.deleteHormone(id);
    _loadHormones();
    _notificationService.cancelNotification(id);
  }

  void _scheduleNotification(Hormone hormone) {
    _notificationService.scheduleHormoneScheduleNotification(
      hormone.id,
      'Hormone Schedule',
      'It\'s time to take your ${hormone.name} dosage.',
      hormone.schedule,
    );
  }

  void _showAddHormoneDialog() {
    final nameController = TextEditingController();
    final dosageController = TextEditingController();
    final scheduleController = TextEditingController();
    final purposeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Hormone'),
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
                keyboardType: TextInputType.datetime,
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
                _addHormone(
                  nameController.text,
                  double.parse(dosageController.text),
                  DateTime.parse(scheduleController.text),
                  purposeController.text,
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

  void _showEditHormoneDialog(Hormone hormone) {
    final nameController = TextEditingController(text: hormone.name);
    final dosageController = TextEditingController(text: hormone.dosage.toString());
    final scheduleController = TextEditingController(text: hormone.schedule.toIso8601String());
    final purposeController = TextEditingController(text: hormone.purpose);

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
                keyboardType: TextInputType.datetime,
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
                _editHormone(
                  hormone.id,
                  nameController.text,
                  double.parse(dosageController.text),
                  DateTime.parse(scheduleController.text),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Hormone Schedule'),
      ),
      body: ListView.builder(
        itemCount: _hormones.length,
        itemBuilder: (context, index) {
          final hormone = _hormones[index];
          return HormoneCard(
            name: hormone.name,
            dosage: hormone.dosage,
            schedule: hormone.schedule.toIso8601String(),
            purpose: hormone.purpose,
            onEdit: () => _showEditHormoneDialog(hormone),
            onDelete: () => _deleteHormone(hormone.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHormoneDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
