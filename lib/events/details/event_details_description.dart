import 'package:flutter/material.dart';

import 'event_details_text_field.dart';

class EventDetailsDescription extends StatelessWidget {
  final TextEditingController controller;
  final bool updateMode;
  final _textStyle = const TextStyle(color: Colors.black, fontSize: 28.0);

  const EventDetailsDescription(
      {Key? key, required this.controller, required this.updateMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EventDetailsTextField(
        controller: controller, textStyle: _textStyle, updateMode: updateMode);
  }
}
