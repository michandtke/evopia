import 'package:evopia/events/start_end_duration_picker.dart';
import 'package:flutter/material.dart';

import 'event.dart';

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
  final imageController = TextEditingController();

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
    imageController.dispose();
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
          _field(imageController, 'image'),
          _field(tagsController, 'tags'),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Added event ${nameController.text}')));
                  var event = Event(
                      id: -1,
                      name: nameController.text,
                      description: descriptionController.text,
                      from: DateTime.parse(fromController.text),
                      to: DateTime.parse(toController.text),
                      place: placeController.text,
                      tags: tagsController.text.split(','),
                      image: imageController.text);
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
}

extension DateTimeExtension on DateTime {
  DateTime roundUp({Duration delta = const Duration(days: 1)}) {
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch -
        millisecondsSinceEpoch % delta.inMilliseconds +
        delta.inMilliseconds);
  }
}
