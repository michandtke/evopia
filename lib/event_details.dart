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
        body: body());
  }

  Widget body() {
    return Column(children: [
      topContent(),
      descriptionWidget(),
    ]);
  }

  Widget topContent() {
    return Stack(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("drive-steering-wheel.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
            height: MediaQuery.of(context).size.height * 0.5,
            padding: const EdgeInsets.all(40.0),
            width: MediaQuery.of(context).size.width,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
            child: Column(
              children: [
                nameWidget(),
                dateAndTime(),
                const Expanded(
                  child: Text(""),
                ),
                tags()
              ],
            )),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget nameWidget() {
    return Text(
      widget.event.name,
      style: const TextStyle(color: Colors.white, fontSize: 45.0),
    );
  }

  Widget descriptionWidget() {
    return Text(widget.event.description,
        style: const TextStyle(fontSize: 24.0));
  }

  Widget dateAndTime() {
    return Text(
      "${widget.event.date} - ${widget.event.time}",
      style: const TextStyle(color: Colors.white, fontSize: 20.0),
    );
  }

  Widget tags() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: widget.event.tags.map((t) => TagEntry(name: t)).toList(),
    );
  }
}
