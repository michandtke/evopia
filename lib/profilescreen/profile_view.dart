import 'package:evopia/loginscreen/credentials_model.dart';
import 'package:evopia/tags/tag.dart';
import 'package:evopia/tags/tag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  final void Function(Tag tag) addTag;

  ProfileView(this.addTag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<CredentialsModel>(builder: (context, credentials, child) {
      return body(credentials);
    }));
  }

  Widget body(CredentialsModel credentials) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(padding: EdgeInsets.only(top: 50)),
        image(credentials.image),
        Padding(
          padding: EdgeInsets.only(top: 30, left: 30),
          child: Text("Hello ${credentials.username}, nice to see you."),
        ),
        Padding(
            padding: EdgeInsets.only(top: 100, left: 30),
            child: Text("CHANNELS")),
        channels(credentials.channels),
        Padding(
            padding: EdgeInsets.only(top: 100, left: 30), child: Text("TAGS")),
        tags(credentials.tags)
      ],
    );
  }

  Widget image(String path) {
    return Center(child: Image.asset(path));
  }

  Widget channels(List channels) {
    return Column(children: channels.map((chan) => Text(chan)).toList());
  }

  Widget tags(List<Tag> tags) {
    return Column(children: [
      ...tags.map((tag) => Text(tag.name)).toList(),
      newTag(tags)
    ]);
  }

  Widget newTag(List<Tag> tagsAlreadyAssigned) {
    var tags = TagProvider()
        .provide()
        .where((element) => !tagsAlreadyAssigned.contains(element));
    return DropdownButton<Tag>(
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
}
