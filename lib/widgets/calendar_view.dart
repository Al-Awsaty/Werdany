import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final HormoneTrackerService _hormoneTrackerService = HormoneTrackerService();
  Map<DateTime, List<dynamic>> _events = {};
  List<dynamic> _selectedEvents = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final hormones = await _hormoneTrackerService.getHormones();
    setState(() {
      _events = _groupEventsByDate(hormones);
    });
  }

  Map<DateTime, List<dynamic>> _groupEventsByDate(List<Map<String, dynamic>> hormones) {
    Map<DateTime, List<dynamic>> events = {};
    for (var hormone in hormones) {
      DateTime date = DateTime.parse(hormone['schedule']);
      if (events[date] == null) events[date] = [];
      events[date]!.add(hormone);
    }
    return events;
  }

  void _onDaySelected(DateTime day, List<dynamic> events) {
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          events: _events,
          onDaySelected: _onDaySelected,
          calendarStyle: CalendarStyle(
            todayColor: Colors.blue,
            selectedColor: Colors.orange,
          ),
        ),
        ..._selectedEvents.map((event) => ListTile(
              title: Text(event['name']),
              subtitle: Text('Dosage: ${event['dosage']} - Purpose: ${event['purpose']}'),
            )),
      ],
    );
  }
}
