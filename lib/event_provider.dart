import 'package:evopia/event.dart';

class EventProvider {
  List<Event> provideEvents() {
    return List.from([event1(), event2(), event3()]);
  }

  Event event1() {
    return Event("Happening", "1", "This is gonna be fun!", "tomorrow", "noon", List.of(["GetTogether", "People"]), "garden");
  }

  Event event2() {
    return Event("Cinema", "2", "Let's watch Dune together", "day after tomorrow", "8 PM", List.of(["Cinema", "Watching"]), "Alhambra");
  }

  Event event3() {
    return Event("Bouldering", "3", "I'm going - feel free to join", "today!", "all day!", List.of(["Sport", "Climbing", "People"]), "Südbloc");
  }
}