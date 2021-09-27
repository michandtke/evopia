import 'package:flutter/material.dart';

import 'event.dart';

class EventEntry extends StatelessWidget {

  final Event event;
  final Color color;

  const EventEntry({Key? key, required this.event, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(dateAndTime(event)),
          Text(event.place),
          tags(event)
        ])
      ],
    ));
  }

  String dateAndTime(Event event) {
    return "${event.date} - ${event.time}";
  }

  Widget tags(Event event) {
    return Row(
      children: event.tags.map((e) => tag(e)).toList(),
    );
  }

  Widget tag(String one) {
    return Text(one);
  }
}