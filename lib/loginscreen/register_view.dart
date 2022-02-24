import 'package:evopia/loginscreen/new_user.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  final Function fnAddNewUser;

  const RegisterView({Key? key, required this.fnAddNewUser}) : super(key: key);

  @override
  State createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _matchingPasswordController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _matchingPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _matchingPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add event"),
        ),
        body: _form());
  }

  Widget _form() {
    return Form(
        key: _formKey,
        child: Column(children: [
          _firstNameField(),
          _lastNameField(),
          _emailField(),
          _passwordField(),
          _matchingPasswordField(),
          _submitButton()
        ]));
  }

  Widget _firstNameField() {
    return TextFormField(
        decoration: const InputDecoration(labelText: "FirstName"),
        controller: _firstNameController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        });
  }

  Widget _lastNameField() {
    return TextFormField(
        decoration: const InputDecoration(labelText: "LastName"),
        controller: _lastNameController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        });
  }

  Widget _emailField() {
    return TextFormField(
        decoration: const InputDecoration(labelText: "Email"),
        controller: _emailController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        });
  }

  Widget _passwordField() {
    return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(labelText: "Password"),
        controller: _passwordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        });
  }

  Widget _matchingPasswordField() {
    return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(labelText: "Matching Password"),
        controller: _matchingPasswordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        });
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            var newUser = NewUser(
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                matchingPassword: _matchingPasswordController.text);
            widget.fnAddNewUser(newUser);
            Navigator.pop(context);
          }
        },
        child: const Text('Submit'));
  }
}
