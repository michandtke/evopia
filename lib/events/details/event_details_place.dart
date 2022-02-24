import 'package:flutter/material.dart';

import 'event_details_text_field.dart';

class EventDetailsPlace extends StatelessWidget {
  final TextEditingController controller;
  final bool updateMode;
  final _textStyle = const TextStyle(color: Colors.black, fontSize: 14.0);

  const EventDetailsPlace(
      {Key? key, required this.controller, required this.updateMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EventDetailsTextField(
        controller: controller, textStyle: _textStyle, updateMode: updateMode);
  }
}
