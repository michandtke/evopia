import 'package:evopia/tags/tag.dart';
import 'package:evopia/user_store.dart';
import 'package:flutter/material.dart';

import '../profilescreen/channel.dart';

class CredentialsModel extends ChangeNotifier {
  var username = "";
  var password = "";
  var image = "";
  List<Tag> tags = [];
  Map<String, Channel> channels = {};

  void loginIn(String username, String password, String image, List<Tag> tags,
      List<Channel> channels) {
    this.username = username;
    this.password = password;
    this.image = image;
    this.tags = tags;
    this.channels =
        channels.asMap().map((key, value) => MapEntry(value.name, value));
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

  void upsertChannel(Channel channel) async {
    channels.update(channel.name, (x) => channel, ifAbsent: () => channel);
    UserStore().upsertChannels(username, password, channels.values.toList());
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
    channels = {};
    notifyListeners();
  }
}
