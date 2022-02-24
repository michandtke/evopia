import 'package:evopia/events/details/event_details_tags.dart';
import 'package:evopia/events/details/event_details_title.dart';
import 'package:evopia/images/event_image.dart';
import 'package:flutter/material.dart';

import '../date_formatter.dart';
import 'event.dart';
import 'event_adder.dart';

class EventDetails extends StatefulWidget {
  final Event event;
  final Function upsertEvent;
  final Function deleteEvent;

  const EventDetails(
      {Key? key,
      required this.event,
      required this.upsertEvent,
      required this.deleteEvent})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  var fontColor = Colors.black;
  bool inUpdateMode = false;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.event.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body());
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
            height: MediaQuery.of(context).size.height * 0.5,
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, bottom: 40.0, top: 60.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                EventDetailsTitle(
                    controller: _nameController, updateMode: inUpdateMode),
                imageWidget(),
                dateAndTime(),
                const Expanded(
                  child: Text(""),
                ),
                _place(),
                EventDetailsTags(tags: widget.event.tags, updateMode: inUpdateMode)
              ],
            )),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventAdder(
                                fnAddEvent: widget.upsertEvent,
                                oldEvent: widget.event,
                              )));
                },
                child: const Icon(Icons.edit, color: Colors.black),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    inUpdateMode = !inUpdateMode;
                    var event = widget.event.copy(newName: _nameController.text);
                    widget.upsertEvent(event);
                  });
                },
                child: const Icon(Icons.edit_attributes, color: Colors.black),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventAdder(
                                fnAddEvent: widget.upsertEvent,
                                oldEvent: widget.event.copyWithoutId(),
                              )));
                },
                child: const Icon(Icons.copy, color: Colors.black),
              ),
              InkWell(
                onTap: () {
                  widget.deleteEvent(widget.event);
                },
                child: const Icon(Icons.delete, color: Colors.black),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget imageWidget() {
    return EventImage(path: widget.event.image);
  }

  Widget nameWidget() {
    return Text(
      widget.event.name,
      style: TextStyle(color: fontColor, fontSize: 45.0),
    );
  }

  Widget descriptionWidget() {
    return Text(widget.event.description,
        style: const TextStyle(fontSize: 24.0));
  }

  Widget dateAndTime() {
    return Text(
      DateFormatter().formatDates(widget.event.from, widget.event.to),
      style: TextStyle(color: fontColor, fontSize: 20.0),
    );
  }

  Widget _place() {
    return Text(widget.event.place);
  }
}
