import 'package:flutter/material.dart';

class CredentialsModel extends ChangeNotifier {
  var username = "";
  var password = "";
  var image = "";
  var tags = [];
  var channels = [];

  void loginIn(String username, String password, String image, List tags,
      List channels) {
    this.username = username;
    this.password = password;
    this.image = image;
    this.tags = tags;
    this.channels = channels;
    notifyListeners();
  }

  bool isLoggedIn() {
    return username.isNotEmpty && password.isNotEmpty;
  }
}
