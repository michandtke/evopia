import 'package:flutter/material.dart';

import 'date_formatter.dart';
import 'event.dart';
import 'event_details.dart';
import 'tag_entry.dart';

class EventEntry extends StatelessWidget {
  final Event event;
  final Color color;
  final BuildContext context;

  const EventEntry({Key? key, required this.event, required this.color, required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap(),
        child: Container(
        padding: const EdgeInsets.all(12.0),
        color: color,
        child: Column(
          children: [
            Text(event.name,
                style: const TextStyle(
                  fontFamily: "Headline",
                  fontSize: 20,
                )),
            Text(event.description),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text(dateAndTime()),
              Text(event.place),
              tags()
            ])
          ],
        )));
  }

  String dateAndTime() {
    return DateFormatter().formatDates(event.from, event.to);
  }

  Widget tags() {
    return Row(
      children: event.tags.map((t) => TagEntry(name: t)).toList(),
    );
  }

  void onTap() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetails(event: event)));
  }
}
