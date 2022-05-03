import 'package:evopia/events/event.dart';
import 'package:evopia/simple_config.dart';

import 'dart:convert';

import 'package:http/http.dart' show Client, Response;

import '../tags/tag.dart';

class EventStore {
  final Client _client = Client();
  final _baseUrl = Uri.parse(SimpleConfig.baseUrl + 'v3/events');
  final _upsertUrl = Uri.parse(SimpleConfig.baseUrl + 'v3/events/upsert');
  final _singleUrl = (id) => Uri.parse(SimpleConfig.baseUrl + 'v3/events/$id');

  Future<Response> upsert(Event event, username, password) {
    var body = json.encode(event.toJson());
    print(body);

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

    var asGenericList =
        _asJson(content).map((json) => Event.fromJson(json)).toList();
    return List<Event>.from(asGenericList);
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
