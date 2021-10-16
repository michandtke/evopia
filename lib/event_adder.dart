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
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final placeController = TextEditingController();
  final tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add event"),
      ),
      body: form()
    );

  }


  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    placeController.dispose();
    tagsController.dispose();
    super.dispose();
  }

  Widget form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _field(nameController, 'name'),
          _field(descriptionController, 'description'),
          _field(dateController, 'date'),
          _field(timeController, 'time'),
          _field(placeController, 'place'),
          _field(tagsController, 'tags'),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added event ${nameController.text}'))
                );
                var event = Event(
                  id: -1,
                  name: nameController.text,
                  description: descriptionController.text,
                  date: dateController.text,
                  time: timeController.text,
                  place: placeController.text,
                  tags: tagsController.text.split(',')
                );
                widget.fnAddEvent(event);
                Navigator.pop(context);
              }
            },
            child: const Text('Submit')
          )
        ]
      )
    );
  }

  Widget _field(TextEditingController controller, String hint) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: hint
      ),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        }
    );
  }

}