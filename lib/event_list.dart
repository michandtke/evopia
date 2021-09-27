import 'package:flutter/material.dart';

import 'event.dart';
import 'event_entry.dart';
import 'evopia_styles.dart';
import 'tag_entry.dart';

class EventList extends StatefulWidget {
  final List<Event> events;

  const EventList({Key? key, required this.events}) : super(key: key);

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  var index = 0;
  List<String> appliedFilters = [];

  @override
  Widget build(BuildContext context) {
    List<Event> shownEvents = calcShownEvents();

    return
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        filters(),
        Column(children: shownEvents.map((e) => createEntry(e)).toList())
      ]);
  }

  List<Event> calcShownEvents() {
    if (appliedFilters.isEmpty) {
      return widget.events;
    }
    return widget.events.where((element) => element.tags.where((t) => appliedFilters.contains(t)).isNotEmpty).toList();
  }

  Row filters() {
    List<String> allFilters = widget.events.expand((e) => e.tags).toList();
    List<Widget> tags = allFilters.map((e) => TagEntry(name: e)).toList();
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tags
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