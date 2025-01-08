import 'package:flutter/material.dart';
import 'package:your_app/services/trainer_profile_service.dart';
import 'package:your_app/models/trainer_profile.dart';
import 'package:your_app/widgets/client_card.dart';

class TrainerDashboardScreen extends StatefulWidget {
  @override
  _TrainerDashboardScreenState createState() => _TrainerDashboardScreenState();
}

class _TrainerDashboardScreenState extends State<TrainerDashboardScreen> {
  List<TrainerProfile> _clients = [];
  final TrainerProfileService _trainerProfileService = TrainerProfileService();

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  Future<void> _loadClients() async {
    final clients = await _trainerProfileService.getClients();
    setState(() {
      _clients = clients;
    });
  }

  void _addClient(TrainerProfile client) async {
    await _trainerProfileService.addClient(client);
    _loadClients();
  }

  void _editClient(TrainerProfile client) async {
    await _trainerProfileService.updateClient(client);
    _loadClients();
  }

  void _deleteClient(int id) async {
    await _trainerProfileService.deleteClient(id);
    _loadClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainer Dashboard'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _clients.length,
              itemBuilder: (context, index) {
                return ClientCard(
                  client: _clients[index],
                  onEdit: _editClient,
                  onDelete: _deleteClient,
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add logic to add, edit, and delete clients
            },
            child: Text('Manage Clients'),
          ),
        ],
      ),
    );
  }
}
