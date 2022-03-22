import 'package:evopia/tags/tag.dart';
import 'package:evopia/user_store.dart';
import 'package:flutter/material.dart';

import '../profilescreen/channel.dart';

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
    await UserStore().upsertTags(username, password, tags);
    notifyListeners();
  }

  void removeTag(Tag tag) async {
    tags.remove(tag);
    await UserStore().upsertTags(username, password, tags);
    notifyListeners();
  }

  void changeImage(String path) async {
    image = path;
    await UserStore().upsertImage(username, password, image);
    notifyListeners();
  }

  void addChannel(Channel channel) async {
    channels.add(channel);
    await UserStore().upsertChannels(username, password, channels);
    notifyListeners();
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
