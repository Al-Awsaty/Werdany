import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class CloudBackupScreen extends StatefulWidget {
  @override
  _CloudBackupScreenState createState() => _CloudBackupScreenState();
}

class _CloudBackupScreenState extends State<CloudBackupScreen> {
  bool _isBackupEnabled = false;
  bool _isSyncing = false;
  String _backupStatus = 'Not backed up';

  final HormoneTrackerService _hormoneTrackerService = HormoneTrackerService();

  @override
  void initState() {
    super.initState();
    _loadBackupSettings();
  }

  Future<void> _loadBackupSettings() async {
    // Load backup settings from the service
    // For now, we'll use dummy data
    setState(() {
      _isBackupEnabled = true;
      _backupStatus = 'Last backup: 2023-09-01';
    });
  }

  Future<void> _toggleBackup(bool value) async {
    setState(() {
      _isBackupEnabled = value;
    });
    if (value) {
      await _startBackup();
    }
  }

  Future<void> _startBackup() async {
    setState(() {
      _isSyncing = true;
      _backupStatus = 'Backing up...';
    });

    try {
      await _hormoneTrackerService.syncWithCloud();
      setState(() {
        _backupStatus = 'Last backup: ${DateTime.now().toString()}';
      });
    } catch (e) {
      setState(() {
        _backupStatus = 'Backup failed';
      });
    } finally {
      setState(() {
        _isSyncing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloud Backup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Enable Cloud Backup'),
              value: _isBackupEnabled,
              onChanged: _toggleBackup,
            ),
            SizedBox(height: 16),
            Text(
              'Backup Status: $_backupStatus',
              style: TextStyle(fontSize: 16),
            ),
            if (_isSyncing) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
