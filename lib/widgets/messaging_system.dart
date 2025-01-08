import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class MessagingSystem extends StatefulWidget {
  final Function(int, String) onSendMessage;

  MessagingSystem({required this.onSendMessage});

  @override
  _MessagingSystemState createState() => _MessagingSystemState();
}

class _MessagingSystemState extends State<MessagingSystem> {
  final TextEditingController _messageController = TextEditingController();
  final HormoneTrackerService _hormoneTrackerService = HormoneTrackerService();
  List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final messages = await _hormoneTrackerService.getMessages();
    setState(() {
      _messages = messages;
    });
  }

  void _sendMessage() {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      widget.onSendMessage(1, message); // Assuming clientId is 1 for now
      _messageController.clear();
      _loadMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return ListTile(
                title: Text(message['content']),
                subtitle: Text(message['timestamp']),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Enter your message',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
