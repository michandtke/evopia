import 'package:flutter/material.dart';

class EventDetailsTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextStyle textStyle;
  final bool updateMode;

  const EventDetailsTextField(
      {Key? key,
      required this.controller,
      required this.textStyle,
      required this.updateMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (updateMode) return _updateMode();
    return _showMode();
  }

  Widget _showMode() {
    return Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.transparent)),
        child: _showField());
  }

  Widget _showField() {
    return TextField(
        controller: controller,
        style: textStyle,
        decoration: null,
        readOnly: true,
        textAlign: TextAlign.center);
  }

  Widget _updateMode() {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: _updateField());
  }

  Widget _updateField() {
    return TextField(
        controller: controller,
        style: textStyle,
        decoration: null,
        readOnly: false,
        textAlign: TextAlign.center);
  }
}
