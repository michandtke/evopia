import 'package:evopia/loginscreen/register_view.dart';
import 'package:evopia/loginscreen/rotating_logo.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../user_store.dart';
import 'credentials_model.dart';

class LoginView extends StatefulWidget {
  final Function fnAddNewUser;

  const LoginView({Key? key, required this.fnAddNewUser}) : super(key: key);

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
    return LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: RotatingLogo(),
        ),
        child: Scaffold(body:
        Consumer<CredentialsModel>(builder: (context, credentials, child) {
      return body(loginIn(credentials));
    })));
  }

  void Function(String, String) loginIn(CredentialsModel credentials) {
    return (String username, String password) async {
      context.loaderOverlay.show();
      var profile = await UserStore().getProfile(username, password);
      credentials.loginIn(username, password, profile.imagePath, profile.tags,
          profile.profileChannels);
      context.loaderOverlay.hide();
    };
  }

  Padding body(void Function(String, String) loginIn) {
    return Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Center(
            child: Column(children: [
          Image.asset("assets/logo.jpg"),
          Text("Willkommen bei Mosaik"),
          form(loginIn),
          _register(),
          // Text("Password vergessen")
        ])));
  }

  Widget form(void Function(String, String) loginIn) {
    return Form(
        key: _formKey,
        child: Column(children: [
          usernameField(),
          passwordField(),
          loginButton(loginIn)
        ]));
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
      obscureText: true,
    );
  }

  Widget loginButton(void Function(String, String) loginIn) {
    return TextButton(
        onPressed: () {
          loginIn(usernameController.text, passwordController.text);
        },
        child: const Text("LOGIN"));
  }

  Widget _register() {
    return TextButton(
        onPressed: () => _navigateToRegisterView(),
        child: const Text("Registrieren"));
  }

  _navigateToRegisterView() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RegisterView(fnAddNewUser: widget.fnAddNewUser)));
  }
}
