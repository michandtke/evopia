import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TimePicker extends StatefulWidget {
  @override
  State createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  RangeValues _currentRangeValues = RangeValues(50, 100);
  DateTime fromMax = DateTime.parse("2020-02-25T00:00Z");
  DateTime toMax = DateTime.parse("2020-02-26T00:00Z");
  DateTime from = DateTime.parse("2020-02-25T11:00Z");
  DateTime to = DateTime.parse("2020-02-25T12:00Z");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add event"),
        ),
        body: _body(context));
  }

  Widget _body(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 80),
        child: Row(
            children: [_dateColumn(), _fancySliderColumn(), _timeColumn()]));
  }

  Widget _dateColumn() {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(fromMax.toIso8601String()),
      Text(_doubleToDuration(1)),
      Text(toMax.toIso8601String())
    ]);
  }

  Widget _fancySliderColumn() {
    // return Expanded(child: Container(color: Colors.blueGrey));
    return RotatedBox(
        quarterTurns: 1,
        child: RangeSlider(
          values: _currentRangeValues,
          max: 1000,
          divisions: 48,
          labels: RangeLabels(
            _label(_currentRangeValues.start.round()),
            _currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
        ));
  }

  String _label(int d) {
    return _doubleToDuration(d);
  }

  Widget _timeColumn() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Time1"), Text("EmptySpace"), Text("Time2")]);
  }

  String _doubleToDuration(int toCalc) {
    int fromMaxInMilli = fromMax.millisecondsSinceEpoch;
    int toMaxInMilli = toMax.millisecondsSinceEpoch;

    var timeBetweenInMilli = toMaxInMilli - fromMaxInMilli;
    // what duration do I have?
    var dur = Duration(milliseconds: timeBetweenInMilli);

    // number to calc is between 0 and 1000
    // let's do 48 steps (half hours)
    double currentStep = toCalc / 48.0;

    var h = timeBetweenInMilli * (toCalc / 1000);
    // var z = Duration(milliseconds: h.toInt());

    var x = timeBetweenInMilli / toCalc;
    var y = fromMaxInMilli + h;
    if (y.isFinite) {
      var dateTime = DateTime.fromMillisecondsSinceEpoch(y.toInt());
      return dateTime.toIso8601String();
    }
    return "";
  }
}
