import 'package:evopia/events/details/event_details_tags.dart';
import 'package:evopia/events/details/event_details_title.dart';
import 'package:evopia/images/event_image.dart';
import 'package:evopia/tags/tags_row.dart';
import 'package:flutter/material.dart';

import '../date_formatter.dart';
import '../tags/tag.dart';
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

  _addTag(Tag tag) {
    widget.event.tags.add(tag);
    widget.upsertEvent(widget.event);
    setState(() {});
  }

  _removeTag(Tag tag) {
    widget.event.tags.remove(tag);
    widget.upsertEvent(widget.event);
    setState(() {});
  }

  Widget topContent() {
    return Stack(
      children: <Widget>[
        _page(),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: topButtons(),
        )
      ],
    );
  }

  Row topButtons() {
    return Row(
      children: [
        _topButton(() => Navigator.pop(context), Icons.arrow_back),
        _topButton(_navigateToEditEvent, Icons.edit),
        _topButton(_stateChangeInlineUpdate, Icons.edit_attributes),
        _topButton(_navigateToCopy, Icons.copy),
        _topButton(() => widget.deleteEvent(widget.event), Icons.delete)
      ],
    );
  }

  void _navigateToEditEvent() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventAdder(
                  fnAddEvent: widget.upsertEvent,
                  oldEvent: widget.event,
                )));
  }

  void _stateChangeInlineUpdate() {
    var event = widget.event.copy(newName: _nameController.text);
    widget.upsertEvent(event);
    setState(() {
      inUpdateMode = !inUpdateMode;
    });
  }

  void _navigateToCopy() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventAdder(
                  fnAddEvent: widget.upsertEvent,
                  oldEvent: widget.event.copyWithoutId(),
                )));
  }

  Widget _topButton(void Function() onTap, IconData icon) {
    return InkWell(onTap: onTap, child: Icon(icon, color: Colors.black));
  }

  Container _page() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.only(
            left: 40.0, right: 40.0, bottom: 40.0, top: 60.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: _realContent(),
        ));
  }

  List<Widget> _realContent() {
    return [
      EventDetailsTitle(controller: _nameController, updateMode: inUpdateMode),
      imageWidget(),
      dateAndTime(),
      const Expanded(
        child: Text(""),
      ),
      _place(),
      TagsRow(
          tags: widget.event.tags,
          addTag: _addTag,
          removeTag: _removeTag,
          editMode: inUpdateMode)
    ];
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
