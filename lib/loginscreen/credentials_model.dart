import 'package:evopia/tags/tag.dart';
import 'package:flutter/material.dart';

class CredentialsModel extends ChangeNotifier {
  var username = "";
  var password = "";
  var image = "";
  List<Tag> tags = [];
  var channels = [];

  void loginIn(String username, String password, String image, List<Tag> tags,
      List channels) {
    this.username = username;
    this.password = password;
    this.image = image;
    this.tags = tags;
    this.channels = channels;
    notifyListeners();
  }

  void addTag(Tag tag) {
    tags.add(tag);
    notifyListeners();
  }

  bool isLoggedIn() {
    return username.isNotEmpty && password.isNotEmpty;
  }
}
