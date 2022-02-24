import 'package:evopia/loginscreen/credentials_model.dart';
import 'package:evopia/tags/tag.dart';
import 'package:evopia/tags/tag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../picker.dart';

class ProfileView extends StatelessWidget {
  final void Function(Tag tag) addTag;
  final void Function(Tag tag) removeTag;
  final void Function(String path) changeImage;

  const ProfileView(this.addTag, this.removeTag, this.changeImage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<CredentialsModel>(builder: (context, credentials, child) {
      return body(credentials, context);
    }));
  }

  Widget body(CredentialsModel credentials, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(padding: EdgeInsets.only(top: 50)),
        image(credentials.image, context),
        Padding(
          padding: EdgeInsets.only(top: 30, left: 30),
          child: Text("Hello ${credentials.username}, nice to see you."),
        ),
        Padding(
            padding: EdgeInsets.only(top: 80, left: 30),
            child: Text("CHANNELS")),
        channels(credentials.channels),
        Padding(
            padding: EdgeInsets.only(top: 80, left: 30), child: Text("TAGS")),
        tags(credentials.tags),
        _logout(credentials, context)
      ],
    );
  }

  Widget image(String path, BuildContext context) {
    return GestureDetector(
      onTap: () {
        newImage(context);
      }, // Image tapped
      child: Center(child: Image.asset(path))
    );
  }

  newImage(BuildContext context) async {
    String? imagePath = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Picker(prefix: 'assets/profiles')));

    if (imagePath != null) {
      changeImage(imagePath);
    }
  }

  Widget channels(List channels) {
    return Column(children: channels.map((chan) => Text(chan)).toList());
  }

  Widget tags(List<Tag> tags) {
    List<Widget> tagChips = tags
        .map((tag) => InputChip(
        avatar: const Icon(Icons.remove),
        label: Text(tag.name),
        onSelected: (sel) {
          if (sel) {
            removeTag(tag);
          }
        }))
        .toList();
    return Column(children: [
      Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: [...tagChips, newTag(tags)])
    ]);
  }

  Widget newTag(List<Tag> tagsAlreadyAssigned) {
    var tags = TagProvider()
        .provide()
        .where((element) => !tagsAlreadyAssigned.contains(element));
    return DropdownButton<Tag>(
      hint: const Chip(label: Icon(Icons.add_sharp)),
      icon: Container(),
      underline: Container(),

      items: tags
          .map(
              (tag) => DropdownMenuItem<Tag>(value: tag, child: Text(tag.name)))
          .toList(),
      onChanged: (tag) {
        if (tag != null) {
          addTag(tag);
        }
      },
    );
  }

  Widget _logout(CredentialsModel credentialsModel, BuildContext context) {
    return TextButton(onPressed: () {
      credentialsModel.logOut();
      Navigator.pop(context);
    }, child: const Text("Logout"));
  }
}
