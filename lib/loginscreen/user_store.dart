import 'dart:convert';

import 'package:http/http.dart';

import 'new_user.dart';

class UserStore {
  final Client _client = Client();
  final _baseUrl = Uri.parse('https://XXX.com/user/registration');

  Future<Response> upsert(NewUser newUser) {
    Map data = {
      'firstName': newUser.firstName,
      'lastName': newUser.lastName,
      'password': newUser.password,
      'matchingPassword': newUser.matchingPassword,
      'email': newUser.email
    };
    var body = json.encode(data);
    return _client.post(_baseUrl,
        headers: {
          "Content-Type": "application/json"
        },
        body: body);
  }
}