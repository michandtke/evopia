import 'package:evopia/events/tag_entry.dart';
import 'package:evopia/images/event_image.dart';
import 'package:flutter/material.dart';

import '../date_formatter.dart';
import 'event.dart';
import 'event_adder.dart';

class EventDetails extends StatefulWidget {
  final Event event;
  final Function upsertEvent;

  const EventDetails({Key? key, required this.event, required this.upsertEvent})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  var fontColor = Colors.black;

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
                nameWidget(),
                imageWidget(),
                dateAndTime(),
                const Expanded(
                  child: Text(""),
                ),
                _tags(),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventAdder(
                                fnAddEvent: widget.upsertEvent,
                                oldEvent: widget.event.copyWithoutId(),
                              )));
                },
                child: const Icon(Icons.copy, color: Colors.black),
              )
            ],
          ),
        )
      ],
    );
  }

  // BoxDecoration backgroundDecoration() {
  //   print(widget.event.image);
  //
  //   if (widget.event.image.isEmpty) {
  //     return const BoxDecoration(
  //         color: Color.fromRGBO(182, 199, 196, 0.5019607843137255));
  //   }
  //
  //   // PictureProvider p = EventImage(path: widget.event.image).x();
  //
  //   // return BoxDecoration(
  //   //     image: DecorationImage(
  //   //         image: EventImage(path: widget.event.image).x(),
  //   //         colorFilter: ColorFilter.mode(
  //   //             Colors.black.withOpacity(0.3), BlendMode.dstATop),
  //   //         fit: BoxFit.cover));
  //   // return BoxDecoration(
  //   //   image: DecorationImage(
  //   //     image: CachedNetworkImageProvider(widget.event.image),
  //   //     colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
  //   //     fit: BoxFit.cover
  //   //   )
  //   // );
  // }

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

  Widget _tags() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children:
          widget.event.tags.map((t) => Chip(label: Text(t.name))).toList(),
    );
  }
}
