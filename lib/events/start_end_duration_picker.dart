import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class StartEndDurationPicker extends StatefulWidget {
  final TextEditingController fromController;
  final TextEditingController toController;

  const StartEndDurationPicker(
      {Key? key, required this.fromController, required this.toController})
      : super(key: key);

  @override
  State createState() => _StartEndDurationPickerState();
}

class _StartEndDurationPickerState extends State<StartEndDurationPicker> {
  final durationController =
      TextEditingController(text: const Duration(minutes: 60).toHoursMinutes());

  @override
  Widget build(BuildContext context) {
    return Column(children: [_fromField(), _toField(), _durationField()]);
  }

  @override
  void dispose() {
    durationController.dispose();
    super.dispose();
  }

  Widget _fromField() {
    var labelText = 'from ${widget.fromController.text}';
    return MaterialButton(
        onPressed: () =>
            showDateTimePicker(_fromChanged, widget.fromController.text),
        child: Text(labelText));
  }

  Widget _toField() {
    var labelText = 'to ${widget.toController.text}';
    return MaterialButton(
        onPressed: () =>
            showDateTimePicker(_toChanged, widget.toController.text),
        child: Text(labelText));
  }

  void showDateTimePicker(Function cb, String currentTime) {
    DatePicker.showDateTimePicker(context, showTitleActions: true,
        onChanged: (date) {
      print('change $date in time zone ' +
          date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date) {
      cb(date);
      var newDuration = _calculateNewDuration();
      setState(() {
        durationController.text = newDuration;
      });
      print('confirm $date');
    }, currentTime: DateTime.tryParse(currentTime) ?? DateTime.now());
  }

  String _calculateNewDuration() {
    var from = DateTime.parse(widget.fromController.text);
    var to = DateTime.parse(widget.toController.text);
    var newDuration = to.difference(from);
    return newDuration.toHoursMinutes();
  }

  Widget _durationField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'duration'),
        controller: durationController,
        onChanged: (value) {
          Duration? newDuration = Duration().parse(value);
          if (newDuration != null) {
            var oldFrom = DateTime.parse(widget.fromController.text);
            setState(() {
              widget.toController.text = oldFrom.add(newDuration).toString();
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        });
  }

  _fromChanged(DateTime newFrom) {
    widget.fromController.text = newFrom.toString();
    DateTime oldTo = DateTime.parse(widget.toController.text);
    Duration? oldDuration = const Duration().parse(durationController.text);
    if (newFrom.isAfter(oldTo) && oldDuration != null) {
      DateTime newTo = newFrom.add(oldDuration);
      widget.toController.text = newTo.toString();
    } else {
      _calculateNewDuration();
    }
  }

  _toChanged(DateTime newTo) {
    widget.toController.text = newTo.toString();
    DateTime oldFrom = DateTime.parse(widget.fromController.text);
    Duration? oldDuration = const Duration().parse(durationController.text);
    if (newTo.isBefore(oldFrom) && oldDuration != null) {
      DateTime newFrom = newTo.subtract(oldDuration);
      widget.fromController.text = newFrom.toString();
    } else {
      _calculateNewDuration();
    }
  }
}

extension DurationExtensions on Duration {
  /// Converts the duration into a readable string
  /// 05:15
  String toHoursMinutes() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes";
  }

  /// Converts the duration into a readable string
  /// 05:15:35
  String toHoursMinutesSeconds() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = _toTwoDigits(inSeconds.remainder(60));
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Duration? parse(String durationInHoursMinutes) {
    List<String> splitted = durationInHoursMinutes.split(":");
    if (splitted.length != 2) {
      return null;
    }
    String hours = splitted[0];
    String minutes = splitted[1];
    if (int.tryParse(hours) != null && int.tryParse(minutes) != null) {
      return Duration(hours: int.parse(hours), minutes: int.parse(minutes));
    }
    return null;
  }

  String _toTwoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
}
