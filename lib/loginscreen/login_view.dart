import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Center(
                child: Column(children: [
              Text("Willkommen bei Mosaik"),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text("Username"),
                Text("________"),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Password"),
                  Text("________"),
                ],
              ),
              TextButton(onPressed: () {}, child: Text("LOGIN")),
              Text(
                "Registrieren",
              ),
              Text("Password vergessen")
            ]))));
  }
}
