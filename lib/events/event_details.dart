import 'package:evopia/events/details/date_and_time_picker.dart';
import 'package:evopia/events/details/event_details_description.dart';
import 'package:evopia/events/details/event_details_place.dart';
import 'package:evopia/events/details/event_details_title.dart';
import 'package:evopia/images/pickable_image.dart';
import 'package:evopia/tags/tags_row.dart';
import 'package:flutter/material.dart';

import '../tags/tag.dart';
import 'event.dart';

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
  late String _imagePath;
  late Event _lastSavedEvent;
  late DateTime _from;
  late DateTime _to;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.event.name);
    _placeController = TextEditingController(text: widget.event.place);
    _descriptionController =
        TextEditingController(text: widget.event.description);
    _tags = List.from(widget.event.tags);
    _imagePath = widget.event.imagePath;
    _lastSavedEvent = widget.event;
    _from = widget.event.from;
    _to = widget.event.to;
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
          top: 40.0,
          child: topButtons(),
        )
      ],
    );
  }

  Row topButtons() {
    return Row(
      children: [
        _topButton(() => Navigator.pop(context), Icons.arrow_back),
        _topButton(_stateChangeInlineUpdate, _editIcon()),
        _topButton(_navigateToCopy, Icons.copy),
        _topButton(() => widget.deleteEvent(widget.event), Icons.delete)
      ],
    );
  }

  IconData _editIcon() {
    if (inUpdateMode) return Icons.save;
    return Icons.edit;
  }

  void _stateChangeInlineUpdate() {
    var event = _lastSavedEvent.copy(
        newName: _nameController.text,
        newPlace: _placeController.text,
        newDescription: _descriptionController.text,
        newTags: _tags,
        newImagePath: _imagePath,
        newFrom: _from,
        newTo: _to);
    if (event != _lastSavedEvent) {
      print("Something in the event changed. Upserting!");
      print(widget.event.toString());
      print(event.toString());
      widget.upsertEvent(event);
      setState(() {
        _lastSavedEvent = event;
        inUpdateMode = !inUpdateMode;
      });
    } else {
      setState(() {
        inUpdateMode = !inUpdateMode;
      });
    }
  }

  void _navigateToCopy() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventDetails(
                  upsertEvent: widget.upsertEvent,
                  deleteEvent: widget.deleteEvent,
                  event: widget.event.copyWithoutId(),
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
      PickableImage(
          updateMode: inUpdateMode,
          imagePath: _imagePath,
          onImagePick: onImagePick),
      DateAndTimePicker(
          inUpdateMode: inUpdateMode,
          from: _from,
          to: _to,
          onChange: (start, end) => setState(() {
                _from = start;
                _to = end;
              })),
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

  void onImagePick(String? newPath) {
    if (newPath != null) {
      setState(() {
        _imagePath = newPath;
      });
    }
  }
}
