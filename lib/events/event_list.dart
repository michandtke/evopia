import 'package:evopia/events/new_event_card.dart';
import 'package:evopia/tags/tag.dart';
import 'package:flutter/material.dart';

import 'event.dart';

class EventList extends StatefulWidget {
  final List<Event> events;
  final Function deleteEvent;
  final List<Tag> myTags;

  const EventList({Key? key, required this.events, required this.deleteEvent, required this.myTags})
      : super(key: key);

  @override
  State<EventList> createState() => _EventListState(List.from(myTags));
}

class _EventListState extends State<EventList> {
  List<Tag> appliedFilters;
  bool allEvents = false;
  bool oneEvent = false;
  bool myEvents = true;

  _EventListState(this.appliedFilters);

  @override
  Widget build(BuildContext context) {
    List<Event> shownEvents = calcShownEvents();

    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      filters(),
      Expanded(
          child: ListView.builder(
              itemCount: shownEvents.length,
              itemBuilder: (BuildContext ctxt, int index) {
                var entry = shownEvents[index];
                var entryWidget = createEntry(entry);
                return entryWidget;
                // return Dismissible(
                //     key: Key(entry.hashCode.toString()),
                //     child: entryWidget,
                //     onDismissed: (direction) {
                //       widget.deleteEvent(entry);
                //       ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(content: Text('${entry.name} dismissed')));
                //     });
              }))
    ]);
  }

  List<Event> calcShownEvents() {
    if (appliedFilters.isEmpty) {
      return widget.events;
    }
    return widget.events
        .where((element) =>
            element.tags.where((t) => appliedFilters.contains(t)).isNotEmpty)
        .toList();
  }

  Widget filters() {
    var chipMy = ChoiceChip(
      label: const Text("My Events"),
      onSelected: (y) => _selectMy(),
      selected: myEvents,
    );
    var chipAll = ChoiceChip(
      label: const Text("All Events"),
      onSelected: (y) => _selectAll(),
      selected: allEvents,
    );
    var chipChoose = ChoiceChip(
      label: const Text("Choose one"),
      onSelected: (y) => _selectOne(),
      selected: oneEvent,
    );
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [chipMy, chipAll, chipChoose]);
  }

  void _selectAll() {
    setState(() {
      appliedFilters = List.empty();
      myEvents = false;
      allEvents = true;
      oneEvent = false;
    });
  }

  void _selectMy() {
    setState(() {
      appliedFilters = widget.myTags;
      myEvents = true;
      allEvents = false;
      oneEvent = false;
    });
  }

  void _selectOne() {
    setState(() {
      appliedFilters = List.empty();
      myEvents = false;
      allEvents = false;
      oneEvent = true;
    });
  }

  Widget createEntry(Event event) {
    return NewEventCard(event: event, context: context);
  }
}
