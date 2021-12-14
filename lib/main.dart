import 'package:evopia/events/event_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'events/event.dart';
import 'events/event_adder.dart';
import 'events/event_store.dart';
import 'loginscreen/credentials_model.dart';
import 'loginscreen/login_view.dart';
import 'profilescreen/profile_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CredentialsModel(),
      child: MaterialApp(
      title: 'Evopia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Events'),
      home: MainScreen(),
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
          return MyHomePage(credentialsModel: credentials);
          // return ProfileView();
        }
        return const LoginView();
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.credentialsModel})
      : super(key: key);

  final CredentialsModel credentialsModel;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Future<List<Event>> eventsFuture = EventStore().get(
        widget.credentialsModel.username, widget.credentialsModel.password);
    return Scaffold(
      body: Column(children: [
        customAppBar(),
        Expanded(child: futureEventsList(eventsFuture))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddEvent,
        tooltip: 'Add event',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget customAppBar() {
    return Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Willkommen bei Mosaik"),
            IconButton(
                icon: Image.asset(widget.credentialsModel.image),
                iconSize: 50,
                onPressed: _navigateToProfilePage)
          ],
        ));
  }

  Center futureEventsList(Future<List<Event>> eventsFuture) {
    return Center(
        child: FutureBuilder(
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
            }));
  }

  void _navigateToProfilePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileView(widget.credentialsModel.addTag)));
  }

  void _navigateToAddEvent() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventAdder(fnAddEvent: _addEvent)));
  }

  void _addEvent(Event newEvent) async {
    var response = await EventStore().add(newEvent,
        widget.credentialsModel.username, widget.credentialsModel.password);
    print("${response.statusCode}");
    print(response.body);
    setState(() {});
  }

  void _deleteEvent(Event toDelete) async {
    var response = await EventStore().delete(toDelete,
        widget.credentialsModel.username, widget.credentialsModel.password);
    print("${response.statusCode}");
    print(response.body);
    setState(() {});
  }
}
