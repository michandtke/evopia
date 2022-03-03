import 'package:evopia/tags/tag.dart';
import 'package:flutter/material.dart';

import '../profilescreen/channel.dart';
import 'new_profile.dart';
import 'profile_store.dart';

class CredentialsModel extends ChangeNotifier {
  var username = "";
  var password = "";
  var image = "";
  List<Tag> tags = [];
  List<Channel> channels = [];

  void loginIn(String username, String password, String image, List<Tag> tags,
      List<Channel> channels) {
    this.username = username;
    this.password = password;
    this.image = image;
    this.tags = tags;
    this.channels = channels;
    notifyListeners();
  }

  void addTag(Tag tag) async {
    tags.add(tag);
    await _adjustProfile();
    notifyListeners();
  }

  void removeTag(Tag tag) async {
    tags.remove(tag);
    await _adjustProfile();
    notifyListeners();
  }

  void changeImage(String path) async {
    image = path;
    await _adjustProfile();
    notifyListeners();
  }

  Future<void> _adjustProfile() async {
    var newProfile = NewProfile(
        image: image,
        tags: tags,
        channels: channels);

    var response = await ProfileStore()
        .upsertProfile(username, password, newProfile);

    print(response.body);
  }

  bool isLoggedIn() {
    return username.isNotEmpty && password.isNotEmpty;
  }

  void logOut() {
    username = "";
    password = "";
    image = "";
    tags = [];
    channels = [];
    notifyListeners();
  }
}
