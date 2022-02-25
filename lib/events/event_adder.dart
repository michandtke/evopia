import 'package:evopia/events/start_end_duration_picker.dart';
import 'package:evopia/images/event_image.dart';
import 'package:evopia/images/pickable_image.dart';
import 'package:evopia/tags/tag_provider.dart';
import 'package:flutter/material.dart';

import '../picker.dart';
import 'event.dart';

import 'package:image_picker/image_picker.dart';

class EventAdder extends StatefulWidget {
  final Function fnAddEvent;
  final Event oldEvent;

  const EventAdder({Key? key, required this.fnAddEvent, required this.oldEvent})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventAdderState();
}

class _EventAdderState extends State<EventAdder> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _fromController;
  late TextEditingController _toController;
  late TextEditingController _placeController;
  late TextEditingController _tagsController;

  String? imagePath = "";

  ImagePicker picker = ImagePicker();


  @override
  void initState() {
    super.initState();
    final ev = widget.oldEvent;
    _nameController = TextEditingController(text: ev.name);
    _descriptionController = TextEditingController(text: ev.description);
    _placeController = TextEditingController(text: ev.place);
    _tagsController = TextEditingController(text: ev.tags.join(","));
    _fromController = TextEditingController(text: ev.from.toString());
    imagePath = ev.image;
    _toController = TextEditingController(text: ev.to.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add event"),
        ),
        body: form());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _placeController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Widget form() {
    return Form(
        key: _formKey,
        child: Column(children: [
          _field(_nameController, 'name'),
          _field(_descriptionController, 'description'),
          StartEndDurationPicker(
              fromController: _fromController, toController: _toController),
          _field(_placeController, 'place'),
          PickableImage(imagePath: imagePath, onImagePick: onImagePick),
          _field(_tagsController, 'tags'),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Added event ${_nameController.text}')));
                  var path = imagePath;
                  var event = Event(
                      id: widget.oldEvent.id,
                      name: _nameController.text,
                      description: _descriptionController.text,
                      from: DateTime.parse(_fromController.text),
                      to: DateTime.parse(_toController.text),
                      place: _placeController.text,
                      tags: TagProvider()
                          .provideSome(_tagsController.text.split(',')),
                      image: path ?? "");
                  widget.fnAddEvent(event);
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'))
        ]));
  }

  Widget _field(TextEditingController controller, String hint) {
    return TextFormField(
        decoration: InputDecoration(labelText: hint),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        });
  }

  void onImagePick(String? path) async {
    if (path != null) {
      setState(() {
        imagePath = path;
      });
    }
  }
}

extension DateTimeExtension on DateTime {
  DateTime roundUp({Duration delta = const Duration(days: 1)}) {
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch -
        millisecondsSinceEpoch % delta.inMilliseconds +
        delta.inMilliseconds);
  }
}
