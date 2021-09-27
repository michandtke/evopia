import 'package:flutter/material.dart';

import 'event.dart';
import 'event_entry.dart';
import 'evopia_styles.dart';

class EventList extends StatefulWidget {
  final List<Event> events;

  const EventList({Key? key, required this.events}) : super(key: key);

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.events.map((e) => createEntry(e)).toList(),
    );
  }

  Widget createEntry(Event event) {
    return EventEntry(event: event, color: _color(index++));
  }

  Color _color(int index) {
    if (index % 2 == 0) return EvopiaStyles.entryColor;
    return EvopiaStyles.alternateEntryColor;
  }
}