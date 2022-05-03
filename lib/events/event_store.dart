import 'package:evopia/events/event.dart';
import 'package:evopia/simple_config.dart';

import 'dart:convert';

import 'package:http/http.dart' show Client, Response;

import '../tags/tag.dart';

class EventStore {
  final Client _client = Client();
  final _baseUrl = Uri.parse(SimpleConfig.baseUrl + 'v3/events');
  final _upsertUrl = Uri.parse(SimpleConfig.baseUrl + 'v3/events/upsert');
  final _singleUrl =
      (id) => Uri.parse(SimpleConfig.baseUrl + 'v3/events/$id');

  Future<Response> upsert(Event event, username, password) {
    var data2 = event.toJson();
    Map data = {
      'name': event.name,
      'description': event.description,
      'date': event.from.toIso8601String(),
      'time': event.to.toIso8601String(),
      'place': event.place,
      'tags': event.tags.join(','),
      'image': event.image
    };
    if (event.id != -1) {
      data.putIfAbsent('id', () => event.id);
    }

    var body = json.encode(data2);
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return _client.post(_upsertUrl,
        headers: {
          "Authorization": basicAuth,
          "Content-Type": "application/json"
        },
        body: body);
  }

  Future<List<Event>> get(username, password, onError) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var content =
        await _client.get(_baseUrl, headers: {"Authorization": basicAuth});
    if (content.statusCode != 200) {
      onError(content);
      return List.empty();
    }

    var jsoned = _asJson(content);
    List<dynamic> json = jsoned;
    var events = json.whereType<Map>().map((entry) {
      var id = entry['id'] ?? -1;
      var name = entry['name'] ?? "";
      var description = entry['description'] ?? "";
      var from = DateTime.parse(entry['date']);
      var to = DateTime.parse(entry['time']);
      var place = entry['place'] ?? "";
      // var tags =
      //     TagProvider().provideSome(entry['tags'].split(",") ?? List.empty());
      List<Tag> tags = List.empty();
      var image = entry['imagePath'] ?? "";

      return Event(
          id: id,
          name: name,
          description: description,
          from: from,
          to: to,
          place: place,
          tags: tags,
          image: image);
    });
    return events.toList();
  }

  _asJson(Response response) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  Future<Response> delete(Event event, username, password) {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return _client.delete(_singleUrl(event.id), headers: {
      "Authorization": basicAuth,
      "Content-Type": "application/json"
    });
  }
}
