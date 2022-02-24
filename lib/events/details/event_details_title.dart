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
    if (updateMode) return _updateMode();
    return _showMode();
  }

  Widget _showMode() {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
        child: _showField());
  }

  Widget _showField() {
    return TextField(
        controller: controller,
        style: _textStyle,
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
        style: _textStyle,
        decoration: null,
        readOnly: false,
        textAlign: TextAlign.center);
  }
}
