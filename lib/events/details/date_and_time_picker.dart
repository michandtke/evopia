import 'package:flutter/material.dart';

import '../../date_formatter.dart';
import '../../timepicker/time_picker.dart';
import '../event.dart';

class DateAndTimePicker extends StatefulWidget {
  final Event event;

  const DateAndTimePicker({Key? key, required this.event}) : super(key: key);

  @override
  State createState() => _DateAndTimePickerState();
}

class _DateAndTimePickerState extends State<DateAndTimePicker> {
  @override
  Widget build(BuildContext context) {
    return _dateAndTime();
  }

  Widget _dateAndTime() {
    return InkWell(child: _dateAndTimeContent(), onTap: _navigateToTimePicker);
  }

  Widget _dateAndTimeContent() {
    return Text(
      DateFormatter().formatDates(widget.event.from, widget.event.to),
      style: const TextStyle(color: Colors.black, fontSize: 20.0),
    );
  }

  void _navigateToTimePicker() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TimePicker()));
  }
}
