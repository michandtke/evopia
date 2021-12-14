import 'package:evopia/tags/tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'credentials_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<CredentialsModel>(
            builder: (context, credentials, child) {
              return body(loginIn(credentials));
            }));
  }

  void Function(String, String) loginIn(CredentialsModel credentials) {
    return (String username, String password) {
      List<Tag> tags = [Tag(name: "Sport"), Tag(name: "Bouldern")];
      var channels = ["0190111222333", "test@test.com", "INSTALINK"];
      var image = "files/default_face.png";
      credentials.loginIn(username, password, image, tags, channels);
    };
  }

  Padding body(void Function(String, String) loginIn) {
    return Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Center(
              child: Column(children: [
            Text("Willkommen bei Mosaik"),
            form(loginIn),
            Text("Registrieren"),
            Text("Password vergessen")
          ])));
  }

  Widget form(void Function(String, String) loginIn) {
    return Form(
      key: _formKey,
      child: Column(children: [
        usernameField(),
        passwordField(),
        loginButton(loginIn)
      ])
    );
  }

  Widget usernameField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Username"),
      controller: usernameController,
    );
  }

  Widget passwordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      controller: passwordController,
    );
  }

  Widget loginButton(void Function(String, String) loginIn) {
    return TextButton(onPressed: () {
      loginIn(usernameController.text, passwordController.text);
    }, child: const Text("LOGIN"));
  }
}
