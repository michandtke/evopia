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
    return Column(children: [
      _fromField(),
      _toField(),
      _durationField()
    ]);
  }

  @override
  void dispose() {
    durationController.dispose();
    super.dispose();
  }

  Widget _fromField() {
    var labelText = 'from ${widget.fromController.text}';
    return MaterialButton(
        onPressed: () => showDateTimePicker(
                (value) => widget.fromController.text = value.toString(), widget.fromController.text),
        child: Text(labelText));
  }

  Widget _toField() {
    var labelText = 'to ${widget.toController.text}';
    return MaterialButton(
        onPressed: () => showDateTimePicker(
                (value) => widget.toController.text = value.toString(), widget.toController.text),
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        });
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

  String _toTwoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
}
