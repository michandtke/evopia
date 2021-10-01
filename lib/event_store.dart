import 'package:evopia/event.dart';

import 'dart:convert';

import 'package:http/http.dart' show Client;

class EventStore {
  final Client _client = Client();
  final _baseUrl = Uri.parse('https://XXX.com/events');

  Future<void> add(Event event) {
    //_events.add(event);
    return Future.value();
  }

  Future<List<Event>> get() async {
    var content = await _client.get(_baseUrl);
    List<dynamic> json = jsonDecode(content.body)['_embedded']['events'];
    var events = json.where((entry) => entry is Map).map((entry) {
      var name = entry['name'] ?? "";
      var description = entry['description'] ?? "";
      var date = entry['date'] ?? "";
      var time = entry['time'] ?? "";
      var place = entry['place'] ?? "";
      var tags = entry['tags'].split(",") ?? List.empty();

      return Event(id: "-1", name: name, description: description, date: date, time: time, place: place, tags: tags);
    });
    return events.toList();
  }
}