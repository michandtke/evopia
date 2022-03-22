import 'package:evopia/loginscreen/credentials_model.dart';
import 'package:evopia/tags/tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../picker.dart';
import '../tags/tags_row.dart';
import 'channel_list.dart';

class ProfileView extends StatelessWidget {
  final void Function(Tag tag) addTag;
  final void Function(Tag tag) removeTag;
  final void Function(String path) changeImage;

  const ProfileView(this.addTag, this.removeTag, this.changeImage, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<CredentialsModel>(builder: (context, credentials, child) {
      return _body(credentials, context);
    }));
  }

  Widget _body(CredentialsModel credentials, BuildContext context) {
    return ListView(children: [
      const Padding(padding: EdgeInsets.only(top: 50)),
      imageButton(credentials.image, context),
      Padding(
        padding: const EdgeInsets.only(top: 30, left: 30),
        child: Text("Hello ${credentials.username}, nice to see you."),
      ),
      const Padding(
          padding: EdgeInsets.only(top: 80, left: 30),
          child: Text("How to reach",
              style: TextStyle(
                  decoration: TextDecoration.underline, wordSpacing: 5))),
      ChannelList(
          channels: credentials.channels,
          fnAddChannel: credentials.addChannel),
      Padding(
          padding: const EdgeInsets.only(top: 80, left: 30),
          child: _tagsSection(credentials)),
      Padding(
          padding: const EdgeInsets.only(top: 10, left: 30),
          child: _logout(credentials, context)),
    ]);
  }

  Widget _tagsSection(CredentialsModel credentials) {
    return Column(children: [
      const Text("TAGS"),
      TagsRow(
          tags: credentials.tags,
          addTag: addTag,
          removeTag: removeTag,
          editMode: true)
    ]);
  }

  Widget imageButton(String path, BuildContext context) {
    return GestureDetector(
        onTap: () {
          newImage(context);
        }, // Image tapped
        child: Center(child: image(path)));
  }

  Widget image(String path) {
    if (path.isEmpty) {
      return const Icon(Icons.person);
    }
    return Image.asset(path);
  }

  newImage(BuildContext context) async {
    String? imagePath = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Picker(prefix: 'assets/profiles')));

    if (imagePath != null) {
      changeImage(imagePath);
    }
  }

  Widget _logout(CredentialsModel credentialsModel, BuildContext context) {
    return TextButton(
        onPressed: () {
          credentialsModel.logOut();
          Navigator.pop(context);
        },
        child: const Text("Logout"));
  }
}
