

import 'dart:convert';

import 'package:http/http.dart';

import 'user.dart';

class UserStore {
  final Client _client = Client();
  final _urlGetProfile = Uri.parse('https://XXX.com/v2/user/profile');

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

}