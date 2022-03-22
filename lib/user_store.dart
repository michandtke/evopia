import 'dart:convert';

import 'package:evopia/profilescreen/channel.dart';
import 'package:evopia/tags/tag.dart';
import 'package:http/http.dart';

import 'user.dart';

class UserStore {
  final Client _client = Client();
  final _urlGetProfile =
      Uri.parse('https://XXX.com/v2/user/profile');
  final _tagUrl =
      Uri.parse('https://XXX.com/v2/user/tags');
  final _imagePathUrl =
      Uri.parse('https://XXX.com/v2/user');
  final _channelUrl =
      Uri.parse('https://XXX.com/v2/user/channel');

  Future<User> getUser(username, password) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var response = await _client.get(_urlGetProfile, headers: {
      "Authorization": basicAuth,
      "Content-Type": "application/json"
    });
    print(response.body);
    var asJson = _asJson(response);
    print(asJson);

    return User.fromJson(asJson);
  }

  _asJson(Response response) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  Future<Response> upsertTags(username, password, List<Tag> tags) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var body = json.encode(tags);
    print(body);
    var response = await _client.post(_tagUrl,
        headers: {
          "Authorization": basicAuth,
          "Content-Type": "application/json"
        },
        body: body);
    print(response.body);
    return response;
  }

  Future<Response> upsertImage(username, password, String imagePath) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var body = '{"imagePath": "' + imagePath + '"}';
    print(body);
    var response = await _client.post(_imagePathUrl,
        headers: {
          "Authorization": basicAuth,
          "Content-Type": "application/json"
        },
        body: body);
    print(response.body);
    return response;
  }

  Future<Response> upsertChannels(
      username, password, List<Channel> channels) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var body = json.encode(channels);
    print(body);
    var response = await _client.post(_channelUrl,
        headers: {
          "Authorization": basicAuth,
          "Content-Type": "application/json"
        },
        body: body);
    print(response.body);
    return response;
  }
}
