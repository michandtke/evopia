import 'package:cached_network_image/cached_network_image.dart';
import 'package:evopia/tag_entry.dart';
import 'package:flutter/material.dart';

import 'date_formatter.dart';
import 'event.dart';

class EventDetails extends StatefulWidget {
  final Event event;

  const EventDetails({Key? key, required this.event}) : super(key: key);

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
            padding: const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 40.0, top: 60.0),
            width: MediaQuery.of(context).size.width,
            decoration: backgroundDecoration(),
            child: Column(
              children: [
                nameWidget(),
                dateAndTime(),
                const Expanded(
                  child: Text(""),
                ),
                tags(),

              ],
            )),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        )
      ],
    );
  }

  BoxDecoration backgroundDecoration() {
    if (widget.event.image.isEmpty) {
      return const BoxDecoration(color: Color.fromRGBO(
          182, 199, 196, 0.5019607843137255));
    }
    return BoxDecoration(
      image: DecorationImage(
        image: CachedNetworkImageProvider(widget.event.image),
        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
        fit: BoxFit.cover
      )
    );
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

  Widget tags() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: widget.event.tags.map((t) => TagEntry(name: t)).toList(),
    );
  }
}
