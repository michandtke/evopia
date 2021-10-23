import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
  final fromController = TextEditingController(text: DateTime.now().toString());
  final toController = TextEditingController(
      text: DateTime.now().add(const Duration(minutes: 30)).toString());
  final placeController = TextEditingController();
  final tagsController = TextEditingController();

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
          _timePickerField(fromController, 'from ${fromController.text}'),
          _timePickerField(toController, 'to ${toController.text}'),
          _field(placeController, 'place'),
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
                      tags: tagsController.text.split(','));
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

  Widget _timePickerField(TextEditingController controller, String buttonText) {
    return MaterialButton(
        onPressed: () => showDateTimePicker(
            (value) => controller.text = value.toString(), controller.text),
        child: Text(buttonText));
  }

  void showDateTimePicker(Function cb, String currentTime) {
    DatePicker.showDateTimePicker(context, showTitleActions: true,
        onChanged: (date) {
      print('change $date in time zone ' +
          date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date) {
      cb(date);
      setState(() {});
      print('confirm $date');
    }, currentTime: DateTime.tryParse(currentTime) ?? DateTime.now());
  }
}
