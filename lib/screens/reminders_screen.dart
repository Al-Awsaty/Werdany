import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';
import 'package:your_app/widgets/reminder_card.dart';

class RemindersScreen extends StatefulWidget {
  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  final HormoneTrackerService _hormoneTrackerService = HormoneTrackerService();
  List<Map<String, dynamic>> _reminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final reminders = await _hormoneTrackerService.getReminders();
    setState(() {
      _reminders = reminders;
    });
  }

  Future<void> _addReminder(String name, String schedule, String purpose) async {
    await _hormoneTrackerService.addReminder(name, schedule, purpose);
    _loadReminders();
  }

  Future<void> _editReminder(int id, String name, String schedule, String purpose) async {
    await _hormoneTrackerService.editReminder(id, name, schedule, purpose);
    _loadReminders();
  }

  Future<void> _deleteReminder(int id) async {
    await _hormoneTrackerService.deleteReminder(id);
    _loadReminders();
  }

  void _showAddReminderDialog() {
    final nameController = TextEditingController();
    final scheduleController = TextEditingController();
    final purposeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Reminder'),
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
                _addReminder(
                  nameController.text,
                  scheduleController.text,
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

  void _showEditReminderDialog(Map<String, dynamic> reminder) {
    final nameController = TextEditingController(text: reminder['name']);
    final scheduleController = TextEditingController(text: reminder['schedule']);
    final purposeController = TextEditingController(text: reminder['purpose']);

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
                _editReminder(
                  reminder['id'],
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
      ),
      body: ListView.builder(
        itemCount: _reminders.length,
        itemBuilder: (context, index) {
          final reminder = _reminders[index];
          return ReminderCard(
            id: reminder['id'],
            name: reminder['name'],
            schedule: reminder['schedule'],
            purpose: reminder['purpose'],
            hormoneTrackerService: _hormoneTrackerService,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddReminderDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
