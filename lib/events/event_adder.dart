import 'dart:developer';
import 'dart:io';

import 'package:evopia/events/start_end_duration_picker.dart';
import 'package:evopia/images/event_image.dart';
import 'package:evopia/tags/tag_provider.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../picker.dart';
import 'event.dart';

import 'package:image_picker/image_picker.dart';

class EventAdder extends StatefulWidget {
  final Function fnAddEvent;

  const EventAdder({Key? key, required this.fnAddEvent}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventAdderState();
}

class _EventAdderState extends State<EventAdder> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final fromController = TextEditingController(
      text: DateTime.now()
          .roundUp(delta: const Duration(minutes: 60))
          .toString());
  final toController = TextEditingController(
      text: DateTime.now()
          .roundUp(delta: const Duration(minutes: 60))
          .add(const Duration(minutes: 60))
          .toString());
  final placeController = TextEditingController();
  final tagsController = TextEditingController();

  String? imagePath = "";

  ImagePicker picker = ImagePicker();

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
    nameController.dispose();
    descriptionController.dispose();
    fromController.dispose();
    toController.dispose();
    placeController.dispose();
    tagsController.dispose();
    super.dispose();
  }

  Widget form() {
    return Form(
        key: _formKey,
        child: Column(children: [
          _field(nameController, 'name'),
          _field(descriptionController, 'description'),
          StartEndDurationPicker(
              fromController: fromController, toController: toController),
          _field(placeController, 'place'),
          _currentImage(),
          _imagePicker(),
          _field(tagsController, 'tags'),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Added event ${nameController.text}')));
                  var path = imagePath;
                  var event = Event(
                      id: -1,
                      name: nameController.text,
                      description: descriptionController.text,
                      from: DateTime.parse(fromController.text),
                      to: DateTime.parse(toController.text),
                      place: placeController.text,
                      tags: TagProvider()
                          .provideSome(tagsController.text.split(',')),
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

  Widget _currentImage() {
    var path = imagePath;
    if (path != null && path.isNotEmpty) {
      return EventImage(path: path);
    }
    return Container();
  }

  Widget _imagePicker() {
    return ElevatedButton(onPressed: pickImage, child: Text("Pick image"));
  }

  void pickImage() async {
    String? imagePath = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Picker()));
    onImagePick(imagePath);
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
