import 'package:evopia/events/details/event_details_description.dart';
import 'package:evopia/events/details/event_details_place.dart';
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
  late TextEditingController _placeController;
  late TextEditingController _descriptionController;
  late List<Tag> _tags;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.event.name);
    _placeController = TextEditingController(text: widget.event.place);
    _descriptionController =
        TextEditingController(text: widget.event.description);
    _tags = List.from(widget.event.tags);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _placeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body());
  }

  Widget body() {
    return Column(children: [
      topContent(),
      EventDetailsDescription(
          controller: _descriptionController, updateMode: inUpdateMode)
    ]);
  }

  _addTag(Tag tag) {
    _tags.add(tag);
    setState(() {});
  }

  _removeTag(Tag tag) {
    _tags.remove(tag);
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
    var event = widget.event.copy(
        newName: _nameController.text,
        newPlace: _placeController.text,
        newDescription: _descriptionController.text,
        newTags: _tags);
    if (event != widget.event) {
      widget.upsertEvent(event);
    }
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
      EventImage(path: widget.event.image),
      dateAndTime(),
      const Expanded(
        child: Text(""),
      ),
      EventDetailsPlace(controller: _placeController, updateMode: inUpdateMode),
      TagsRow(
          tags: _tags,
          addTag: _addTag,
          removeTag: _removeTag,
          editMode: inUpdateMode)
    ];
  }

  Widget dateAndTime() {
    return Text(
      DateFormatter().formatDates(widget.event.from, widget.event.to),
      style: TextStyle(color: fontColor, fontSize: 20.0),
    );
  }
}
