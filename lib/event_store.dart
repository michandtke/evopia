import 'package:evopia/event.dart';

import 'dart:convert';

import 'package:http/http.dart' show Client, Response;

class EventStore {
  final Client _client = Client();
  final _baseUrl = Uri.parse('https://XXX.com/events');
  final _singleUrl = (id) => Uri.parse('https://XXX.com/events/$id');

  Future<Response> add(Event event) {
    Map data = {
      'name': event.name,
      'description': event.description,
      'date': event.from,
      'time': event.to,
      'place': event.place,
      'tags': event.tags.join(',')
    };
    var body = json.encode(data);

    return _client.post(_baseUrl,
        headers: {"Authorization": "Basic XXX", "Content-Type": "application/json"},
        body: body
    );
  }

  Future<List<Event>> get() async {
    var content = await _client.get(_baseUrl,
        headers: {"Authorization": "Basic XXX"}
    );
    List<dynamic> json = jsonDecode(content.body)['_embedded']['events'];
    var events = json.whereType<Map>().map((entry) {
      var id = entry['id'] ?? "";
      var name = entry['name'] ?? "";
      var description = entry['description'] ?? "";
      var from = entry['date'] ?? "";
      var to = entry['time'] ?? "";
      var place = entry['place'] ?? "";
      var tags = entry['tags'].split(",") ?? List.empty();

      return Event(id: id, name: name, description: description, from: from, to: to, place: place, tags: tags);
    });
    return events.toList();
  }

  Future<Response> delete(Event event) {
    return _client.delete(_singleUrl(event.id),
        headers: {"Authorization": "Basic XXX", "Content-Type": "application/json"}
    );
  }
}