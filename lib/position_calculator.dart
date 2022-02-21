import 'events/event.dart';

class PositionCalculator {
  int calcPositionOfToday(List<Event> events) {
    DateTime today = DateTime.now().roundDown();
    Event closestAfterToday = events.reduce((e1, e2) {
      return eventComparer(e1, today, e2);
    });
    return events.indexOf(closestAfterToday);
  }

  Event eventComparer(Event e1, DateTime today, Event e2) {
    bool e1InFuture = !e1.to.difference(today).isNegative;
    bool e2InFuture = !e2.to.difference(today).isNegative;

    if (!e1InFuture && e2InFuture) {
      return e2;
    }
    if (!e2InFuture && e1InFuture) {
      return e1;
    }

    if (e1InFuture && e2InFuture) {
      if (e1.to.isBefore(e2.to)) {
        return e1;
      }
      return e2;
    }

    if (e1.to.isBefore(e2.to)) {
      return e2;
    }
    return e1;
  }
}

extension DateOnlyCompare on DateTime {
  DateTime roundDown({Duration delta = const Duration(days: 1)}) {
    return DateTime.fromMillisecondsSinceEpoch(
        millisecondsSinceEpoch - millisecondsSinceEpoch % delta.inMilliseconds);
  }
}
