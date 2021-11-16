import 'package:evopia/event_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event.dart';
import 'event_adder.dart';
import 'event_store.dart';
import 'loginscreen/credentials_model.dart';
import 'loginscreen/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evopia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Events'),
      home: ChangeNotifierProvider(
        create: (context) => CredentialsModel(),
        child: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CredentialsModel>(
      builder: (context, credentials, child) {
        if (credentials.isLoggedIn()) {
          return MyHomePage(
              username: credentials.username, password: credentials.password);
        }
        return const LoginView();
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.username, required this.password})
      : super(key: key);

  final String username;
  final String password;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Future<List<Event>> eventsFuture =
        EventStore().get(widget.username, widget.password);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
      ),
      body: FutureBuilder(
          future: eventsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return EventList(
                  events: snapshot.data as List<Event>,
                  deleteEvent: _deleteEvent);
            }
            if (snapshot.hasError)
              return Text("Unfortunately, an error: ${snapshot.error}");
            return const CircularProgressIndicator();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddEvent,
        tooltip: 'Add event',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddEvent() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventAdder(fnAddEvent: _addEvent)));
  }

  void _addEvent(Event newEvent) async {
    var response = await EventStore().add(newEvent, widget.username, widget.password);
    print("${response.statusCode}");
    print(response.body);
    setState(() {});
  }

  void _deleteEvent(Event toDelete) async {
    var response = await EventStore().delete(toDelete, widget.username, widget.password);
    print("${response.statusCode}");
    print(response.body);
    setState(() {});
  }
}
