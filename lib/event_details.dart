import 'package:evopia/tag_entry.dart';
import 'package:flutter/material.dart';

import 'event.dart';

class EventDetails extends StatefulWidget {
  final Event event;

  const EventDetails({Key? key, required this.event}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Event details"),
        ),
        body: body()
    );

  }

  Widget body() {
    return Column(children: [
      nameWidget(),
      descriptionWidget(),
      dateAndTime(),
      tags(),
    ]);
  }

  Widget nameWidget() {
    return Text(widget.event.name);
  }

  Widget descriptionWidget() {
    return Text(widget.event.description);
  }

  Widget dateAndTime() {
    return Text("${widget.event.date} - ${widget.event.time}");
  }

  Widget tags() {
    return Row(
      children: widget.event.tags.map((t) => TagEntry(name: t)).toList(),
    );
  }
}