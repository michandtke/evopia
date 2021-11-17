import 'package:evopia/loginscreen/credentials_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
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

  Widget tags(List tags) {
    return Column(children: tags.map((tag) => Text(tag)).toList());
  }
}
