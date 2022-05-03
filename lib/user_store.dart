import 'dart:convert';

import 'package:evopia/loginscreen/profile.dart';
import 'package:evopia/profilescreen/channel.dart';
import 'package:evopia/simple_config.dart';
import 'package:evopia/tags/tag.dart';
import 'package:http/http.dart';

import 'user.dart';

class UserStore {
  final Client _client = Client();
  final _tagUrl = Uri.parse(SimpleConfig.baseUrl + 'v3/user/tags');
  final _userUrl = Uri.parse(SimpleConfig.baseUrl + 'v3/user');
  final _channelUrl = Uri.parse(SimpleConfig.baseUrl + 'v3/user/channel');

  Future<Profile> getProfile(username, password) async {
    var user = await getUser(username, password);
    var channels = await _getUserChannels(username, password);
    var tags = await _getUserTags(username, password);
    return Profile(imagePath: user.imagePath, tags: tags, profileChannels: channels);
  }

  Future<User> getUser(username, password) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var response = await _client.get(_userUrl, headers: {
      "Authorization": basicAuth,
      "Content-Type": "application/json"
    });
    print(response.body);
    var asJson = _asJson(response);
    print(asJson);

    return User.fromJson(asJson);
  }

  Future<List<Channel>> _getUserChannels(username, password) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var response = await _client.get(_channelUrl, headers: {
      "Authorization": basicAuth,
      "Content-Type": "application/json"
    });
    print(response.body);
    var asJson = _asJson(response);
    print(asJson);

    List<Channel> list = List<Channel>.from(
        asJson.map((json) => Channel.fromJson(json)).toList());

    return list;
  }

  Future<List<Tag>> _getUserTags(username, password) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var response = await _client.get(_tagUrl, headers: {
      "Authorization": basicAuth,
      "Content-Type": "application/json"
    });
    print(response.body);
    var asJson = _asJson(response);
    print(asJson);

    List<Tag> list = List<Tag>.from(
        asJson.map((json) => Tag.fromJson(json)).toList());

    return list;
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
    var response = await _client.post(_userUrl,
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
