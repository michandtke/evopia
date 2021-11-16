import 'package:flutter/material.dart';

class CredentialsModel extends ChangeNotifier {
  var username = "";
  var password = "";

  void loginIn(String username, String password) {
    this.username = username;
    this.password = password;
    notifyListeners();
  }

  bool isLoggedIn() {
    return username.isNotEmpty && password.isNotEmpty;
  }
}