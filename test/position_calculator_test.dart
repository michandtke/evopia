import 'package:evopia/events/event.dart';
import 'package:evopia/position_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return e1 when e1 in the future and e2 in the past', () {
    var now = DateTime.now();
    Event futureEvent1 = _testEvent(now.add(const Duration(days: 3)));
    Event pastEvent2 = _testEvent(now.subtract(const Duration(days: 3)));

    Event closestInFuture =
        PositionCalculator().eventComparer(futureEvent1, now, pastEvent2);

    expect(closestInFuture, equals(futureEvent1));
  });

  test('should return e2 when e2 in the future and e1 in the past', () {
    var now = DateTime.now();
    Event pastEvent1 = _testEvent(now.subtract(const Duration(days: 3)));
    Event futureEvent2 = _testEvent(now.add(const Duration(days: 3)));

    Event closestInFuture =
        PositionCalculator().eventComparer(pastEvent1, now, futureEvent2);

    expect(closestInFuture, equals(futureEvent2));
  });

  test('should return e1 when both in future but e1 is nearer', () {
    var now = DateTime.now();
    Event futureEvent1 = _testEvent(now.add(const Duration(minutes: 1)));
    Event futureEvent2 = _testEvent(now.add(const Duration(minutes: 2)));

    Event closestInFuture =
        PositionCalculator().eventComparer(futureEvent1, now, futureEvent2);

    expect(closestInFuture, equals(futureEvent1));
  });

  test('should return e2 when both in future but e2 is nearer', () {
    var now = DateTime.now();
    Event futureEvent1 = _testEvent(now.add(const Duration(minutes: 3)));
    Event futureEvent2 = _testEvent(now.add(const Duration(minutes: 2)));

    Event closestInFuture =
        PositionCalculator().eventComparer(futureEvent1, now, futureEvent2);

    expect(closestInFuture, equals(futureEvent2));
  });

  test('should return e2 when both in past but e2 is nearer', () {
    var now = DateTime.now();
    Event pastEvent1 = _testEvent(now.subtract(const Duration(minutes: 3)));
    Event pastEvent2 = _testEvent(now.subtract(const Duration(minutes: 2)));

    Event closestInFuture =
        PositionCalculator().eventComparer(pastEvent1, now, pastEvent2);

    expect(closestInFuture, equals(pastEvent2));
  });
}

Event _testEvent(DateTime to) {
  return Event(
      id: -1,
      name: "TESTEVENT",
      description: "Some description",
      from: DateTime.utc(0),
      to: to,
      place: "Great place",
      imagePath: "",
      tags: List.empty());
}
