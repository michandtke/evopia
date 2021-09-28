import 'package:evopia/event.dart';

class EventStore {
  final List<Event> _events = List.from([event1, event2, event3]);

  void add(Event event) {
    _events.add(event);
  }

  List<Event> get() {
    return _events.toList();
  }


  // DUMMY DATA
  static Event event1 = Event(name: "Happening", id: "1", description: "This is gonna be fun!", date: "tomorrow", time: "noon", tags: List.of(["GetTogether", "People"]), place: "garden");
  static Event event2 = Event(name: "Cinema", id: "2", description: "Let's watch Dune together", date: "day after tomorrow", time: "8 PM", tags: List.of(["Cinema", "Watching"]), place: "Alhambra");
  static Event event3 = Event(name: "Bouldering", id: "3", description: "I'm going - feel free to join", date: "today!", time: "all day!", tags: List.of(["Sport", "Climbing", "People"]), place: "Südbloc");
}