import 'package:evopia/date_formatter.dart';
import 'package:evopia/images/event_image.dart';
import 'package:flutter/material.dart';

import 'event.dart';
import 'event_details.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Function upsertEvent;
  final Function deleteEvent;
  final BuildContext context;

  const EventCard(
      {Key? key,
      required this.event,
      required this.upsertEvent,
      required this.deleteEvent,
      required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap(),
        child: Card(
            child: Column(
          children: [
            Text(event.name, style: const TextStyle(fontSize: 40)),
            EventImage(path: event.image, height: 120),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_timeWidget(), _peopleWidget()]))
          ],
        )));
  }

  Widget _timeWidget() {
    var timeIcon = const Padding(
        padding: EdgeInsets.only(right: 5), child: Icon(Icons.access_time));
    var timeText = Text(DateFormatter().formatTimes(event.from, event.to));
    return Row(children: [timeIcon, timeText]);
  }

  Widget _peopleWidget() {
    var peopleIcon = const Padding(
        padding: EdgeInsets.only(right: 5), child: Icon(Icons.people));
    var peopleText = const Text("1 - 100");
    return Row(children: [peopleIcon, peopleText]);
  }

  void onTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventDetails(
                event: event,
                upsertEvent: upsertEvent,
                deleteEvent: deleteEvent)));
  }
}
