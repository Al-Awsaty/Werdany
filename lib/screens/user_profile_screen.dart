import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';
import 'package:your_app/models/hormone.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final HormoneTrackerService _hormoneTrackerService = HormoneTrackerService();
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

  Future<void> _addHormone(Hormone hormone) async {
    await _hormoneTrackerService.addHormone(
      hormone.name,
      hormone.dosage,
      hormone.schedule,
      hormone.purpose,
    );
    _loadHormones();
  }

  Future<void> _editHormone(Hormone hormone) async {
    await _hormoneTrackerService.editHormone(
      hormone.id,
      hormone.name,
      hormone.dosage,
      hormone.schedule,
      hormone.purpose,
    );
    _loadHormones();
  }

  Future<void> _deleteHormone(int id) async {
    await _hormoneTrackerService.deleteHormone(id);
    _loadHormones();
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
                  Hormone(
                    id: 0,
                    name: nameController.text,
                    dosage: double.parse(dosageController.text),
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

  void _showEditHormoneDialog(Hormone hormone) {
    final nameController = TextEditingController(text: hormone.name);
    final dosageController = TextEditingController(text: hormone.dosage.toString());
    final scheduleController = TextEditingController(text: hormone.schedule);
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
                  Hormone(
                    id: hormone.id,
                    name: nameController.text,
                    dosage: double.parse(dosageController.text),
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
        title: Text('User Profile'),
      ),
      body: ListView.builder(
        itemCount: _hormones.length,
        itemBuilder: (context, index) {
          final hormone = _hormones[index];
          return ListTile(
            title: Text(hormone.name),
            subtitle: Text('Dosage: ${hormone.dosage}, Schedule: ${hormone.schedule}, Purpose: ${hormone.purpose}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showEditHormoneDialog(hormone),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteHormone(hormone.id),
                ),
              ],
            ),
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
