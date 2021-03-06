import 'package:evopia/events/event_card.dart';
import 'package:evopia/loginscreen/credentials_model.dart';
import 'package:evopia/position_calculator.dart';
import 'package:evopia/profilescreen/profile_view.dart';
import 'package:evopia/tags/tag.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'event.dart';

class EventList extends StatefulWidget {
  final List<Event> events;
  final Function deleteEvent;
  final Function upsertEvent;
  final CredentialsModel credentialsModel;

  const EventList(
      {Key? key,
      required this.events,
      required this.deleteEvent,
      required this.upsertEvent,
      required this.credentialsModel})
      : super(key: key);

  @override
  State<EventList> createState() =>
      _EventListState(List.from(credentialsModel.tags));
}

class _EventListState extends State<EventList> {
  List<Tag> appliedFilters;
  bool allEvents = false;
  bool myEvents = true;
  bool isInOldDates = false;
  late DateTime previousDate;

  _EventListState(this.appliedFilters);

  @override
  Widget build(BuildContext context) {
    List<Event> shownEvents = calcShownEvents();
    return Column(children: [
      filtersAndProfile(),
      Expanded(child: createListViewForEvents(shownEvents))
    ]);
  }

  Widget createListViewForEvents(List<Event> shownEvents) {
    if (shownEvents.isEmpty) {
      return const Text("No events where found.");
    }
    int initialScrollIndex =
        PositionCalculator().calcPositionOfToday(shownEvents);

    previousDate = DateTime(0);
    return ScrollablePositionedList.builder(
        key: UniqueKey(),
        itemCount: shownEvents.length,
        initialScrollIndex: initialScrollIndex,
        itemBuilder: (BuildContext ctxt, int index) {
          return _singleEntryWithDateDivider(shownEvents, index);
        });
  }

  Widget _singleEntryWithDateDivider(List<Event> shownEvents, int index) {
    var event = shownEvents[index];
    if (event.from.isSameDate(previousDate)) {
      var entryWidget = eventEntry(event);
      return entryWidget;
    } else {
      previousDate = event.from;
      var newDateMarker = Padding(
          child: Text(event.from.asDateString()),
          padding: const EdgeInsets.only(left: 15, top: 30));
      var divider = const Divider(color: Colors.black);
      var entryWidget = eventEntry(event);
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [newDateMarker, divider, entryWidget]);
    }
  }

  List<Event> calcShownEvents() {
    final filtered = filterOutOtherEvents(widget.events, appliedFilters);
    filtered.sort((e1, e2) => e2.from.compareTo(e1.from));
    return filtered;
  }

  List<Event> filterOutOtherEvents(
      List<Event> events, List<Tag> appliedFilter) {
    if (allEvents) return events;
    if (appliedFilter.isEmpty) return List.empty();

    return events
        .where((element) =>
            element.tags.where((t) => appliedFilter.contains(t)).isNotEmpty)
        .toList();
  }

  Widget filtersAndProfile() {
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
    return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [chipMy, chipAll, profileIconButton()]));
  }

  Widget profileIconButton() {
    return IconButton(
        icon: profileIcon(), iconSize: 50, onPressed: _navigateToProfilePage);
  }

  Widget profileIcon() {
    if (widget.credentialsModel.image.isEmpty) {
      return const Icon(Icons.person);
    }
    return Image.asset(widget.credentialsModel.image);
  }

  void _navigateToProfilePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileView(
                widget.credentialsModel.addTag,
                widget.credentialsModel.removeTag,
                widget.credentialsModel.changeImage)));
  }

  void _selectAll() {
    setState(() {
      appliedFilters = List.empty();
      myEvents = false;
      allEvents = true;
    });
  }

  void _selectMy() {
    setState(() {
      appliedFilters = widget.credentialsModel.tags;
      myEvents = true;
      allEvents = false;
    });
  }

  Widget eventEntry(Event event) {
    return EventCard(
        event: event,
        upsertEvent: widget.upsertEvent,
        deleteEvent: widget.deleteEvent,
        context: context);
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String asDateString() {
    return DateFormat("dd.MM.yyyy").format(this);
  }
}
