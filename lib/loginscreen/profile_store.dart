import 'dart:convert';

import 'package:http/http.dart';

import '../profilescreen/channel.dart';
import '../tags/tag.dart';
import 'new_profile.dart';

class ProfileStore {
  final Client _client = Client();
  final _baseUrl =
      Uri.parse('https://XXX.com/register/profile');
  final _urlGetProfile =
      Uri.parse('https://XXX.com/profile');

  Future<Response> upsertProfile(username, password, NewProfile newProfile) {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var dataNew = newProfile.toJson();
    print(dataNew);
    var body = json.encode(newProfile);
    print(body);
    return _client.post(_baseUrl,
        headers: {
          "Authorization": basicAuth,
          "Content-Type": "application/json"
        },
        body: body);
  }

  Future<NewProfile> getProfile(username, password) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var response = await _client.get(_urlGetProfile, headers: {
      "Authorization": basicAuth,
      "Content-Type": "application/json"
    });
    print(response.body);
    var asJson = _asJson(response);
    print(asJson);
    // List<Tag> tags = [Tag(name: "Sport"), Tag(name: "Bouldern")];
    // var channels = [
    //   Channel(name: "0190111222333"),
    //   Channel(name: "test@test.com"),
    //   Channel(name: "INSTALINK")
    // ];
    // var image = "files/jeff_smaller.png";

    return NewProfile.fromJson(asJson);

    // return NewProfile(
    //     email: username, image: image, tags: tags, channels: channels);
  }

  _asJson(Response response) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  }
}
