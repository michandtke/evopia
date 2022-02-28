import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:flutter/material.dart';

import '../../date_formatter.dart';

class DateAndTimePicker extends StatefulWidget {
  final DateTime from;
  final DateTime to;
  final bool inUpdateMode;
  final void Function(DateTime, DateTime) onChange;

  const DateAndTimePicker(
      {Key? key,
      required this.inUpdateMode,
      required this.from,
      required this.to,
      required this.onChange})
      : super(key: key);

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
      DateFormatter().formatDates(widget.from, widget.to),
      style: const TextStyle(color: Colors.black, fontSize: 20.0),
    );
  }

  void _navigateToTimePicker() {
    if (widget.inUpdateMode) {
      DateTimeRangePicker(
          startText: "From",
          endText: "To",
          doneText: "Yes",
          cancelText: "Cancel",
          interval: 5,
          initialStartTime: widget.from,
          initialEndTime: widget.to,
          mode: DateTimeRangePickerMode.dateAndTime,
          minimumTime: DateTime.now().subtract(Duration(days: 5)),
          maximumTime: DateTime.now().add(Duration(days: 25)),
          use24hFormat: true,
          onConfirm: (start, end) {
            print(start);
            print(end);
            widget.onChange(start, end);
          }).showPicker(context);
    }
  }
}
