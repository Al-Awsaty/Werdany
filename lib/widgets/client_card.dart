import 'package:flutter/material.dart';
import 'package:your_app/models/trainer_profile.dart';

class ClientCard extends StatelessWidget {
  final Client client;
  final Function(Client) onEdit;
  final Function(int) onDelete;

  ClientCard({
    required this.client,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              client.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Email: ${client.email}'),
            SizedBox(height: 8),
            Text('Phone: ${client.phone}'),
            SizedBox(height: 8),
            Text('Address: ${client.address}'),
            SizedBox(height: 8),
            Text('Schedules:'),
            ...client.schedules.map((schedule) => Text(schedule.name)).toList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => onEdit(client),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onDelete(client.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
