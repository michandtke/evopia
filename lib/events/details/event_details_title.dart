import 'package:evopia/events/details/event_details_text_field.dart';
import 'package:flutter/material.dart';

class EventDetailsTitle extends StatelessWidget {
  final TextEditingController controller;
  final bool updateMode;
  final _textStyle = const TextStyle(color: Colors.black, fontSize: 45.0);

  const EventDetailsTitle(
      {Key? key, required this.controller, required this.updateMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EventDetailsTextField(
        controller: controller, textStyle: _textStyle, updateMode: updateMode);
  }
}
