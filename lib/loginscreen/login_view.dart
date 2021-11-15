import 'package:flutter/material.dart';

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
        body: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Center(
                child: Column(children: [
              Text("Willkommen bei Mosaik"),
              form(),
              Text("Registrieren"),
              Text("Password vergessen")
            ]))));
  }

  Widget form() {
    return Form(
      key: _formKey,
      child: Column(children: [
        usernameField(),
        passwordField(),
        loginButton()
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

  Widget loginButton() {
    return TextButton(onPressed: () {}, child: const Text("LOGIN"));
  }
}
