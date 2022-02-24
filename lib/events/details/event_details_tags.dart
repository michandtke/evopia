import 'package:evopia/tags/tag.dart';
import 'package:flutter/material.dart';

class EventDetailsTags extends StatelessWidget {
  final List<Tag> tags;
  final bool updateMode;

  const EventDetailsTags(
      {Key? key, required this.tags, required this.updateMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (updateMode) return _updateMode();
    return _showMode();
  }

  Widget _updateMode() {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: _updateModeRow());
  }

  Widget _updateModeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: tags
          .map((t) => Padding(
          child: Chip(label: Text(t.name)),
          padding: const EdgeInsets.only(left: 3)))
          .toList(),
    );
  }

  Widget _showMode() {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
        child: _showModeRow());
  }

  Widget _showModeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: tags
          .map((t) => Padding(
              child: Chip(label: Text(t.name)),
              padding: const EdgeInsets.only(left: 3)))
          .toList(),
    );
  }
}
