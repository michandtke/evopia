import 'package:flutter/material.dart';

import 'event.dart';
import 'event_entry.dart';
import '../evopia_styles.dart';
import 'tag_entry.dart';

class EventList extends StatefulWidget {
  final List<Event> events;
  final Function deleteEvent;

  const EventList({Key? key, required this.events, required this.deleteEvent}) : super(key: key);

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
        Expanded(child: ListView.builder(
            itemCount: shownEvents.length,
            itemBuilder: (BuildContext ctxt, int index) {
              var entry = shownEvents[index];
              var entryWidget = createEntry(entry);

              return Dismissible(key: Key(entry.hashCode.toString()),
                  child: entryWidget,
              onDismissed: (direction) {
                widget.deleteEvent(entry);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('${entry.name} dismissed')));
              });
    }))]);
  }

  List<Event> calcShownEvents() {
    if (appliedFilters.isEmpty) {
      return widget.events;
    }
    return widget.events.where((element) => element.tags.where((t) => appliedFilters.contains(t)).isNotEmpty).toList();
  }

  Widget filters() {
    Set<String> allFilters = widget.events.expand((e) => e.tags).toSet();
    List<Widget> tags = allFilters.map((e) => tagButton(e)).toList();
    return Wrap(children: tags);
  }

  Widget tagButton(String name) {
    return MaterialButton(child: TagEntry(name: name, color: appliedFilters.contains(name) ? EvopiaStyles.tagChosenColor : EvopiaStyles.tagDefaultColor),
        onPressed: () {
      if (appliedFilters.contains(name)) {
        setState(() {
          appliedFilters =  appliedFilters.where((element) => element != name).toList();
        });
      } else {
        setState(() {
          List<String> newFilters = appliedFilters.toList();
          newFilters.add(name);
          appliedFilters = newFilters.toList();
        });
      }
    });
  }

  Widget createEntry(Event event) {
    return EventEntry(event: event, color: _color(index++), context: context);
  }

  Color _color(int index) {
    if (index % 2 == 0) return EvopiaStyles.entryColor;
    return EvopiaStyles.alternateEntryColor;
  }
}