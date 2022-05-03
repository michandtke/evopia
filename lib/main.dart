import 'package:evopia/events/event_list.dart';
import 'package:evopia/loginscreen/new_user.dart';
import 'package:evopia/loginscreen/user_store.dart';
import 'package:evopia/picker.dart';
import 'package:evopia/simple_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
        home: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (SimpleConfig.baseUrl.isNotEmpty) {
      return Consumer<CredentialsModel>(
        builder: (context, credentials, child) {
          if (credentials.isLoggedIn()) {
            return MyHomePage(credentialsModel: credentials);
            // return ProfileView();
          }
          return LoginView(fnAddNewUser: (user) => _addNewUser(user, context));
        },
      );
    } else {
      return const Text("Fehler: Config nicht valide. Umgebungsvariablen nicht gesetzt?");
    }
  }

  void _addNewUser(NewUser newUser, BuildContext context) async {
    var response = await UserStore().upsert(newUser);
    print("${response.statusCode}");
    print(response.body);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('Trying to add new user: ${response.statusCode.toString()} - '
                '${response.body}')));
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
        widget.credentialsModel.username,
        widget.credentialsModel.password,
        _onError);
    return Scaffold(
      body: Column(children: [Expanded(child: futureEventsList(eventsFuture))]),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddEvent,
        tooltip: 'Add event',
        child: const Icon(Icons.add),
      ),
    );
  }

  _onError(Response response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error trying to load events: ${response.statusCode.toString()} - '
            '${response.body}')));
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
                    deleteEvent: _deleteEvent,
                    upsertEvent: _upsertEvent,
                    credentialsModel: widget.credentialsModel);
              }
              if (snapshot.hasError) {
                return Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: Column(children: [
                      Text("Unfortunately, an error: ${snapshot.error}"),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(snapshot.stackTrace.toString(),
                              style: const TextStyle(fontSize: 10))),
                      TextButton(
                          onPressed: () => setState(() {}),
                          child: const Text("RELOAD"))
                    ]));
              }
              return const CircularProgressIndicator();
            }));
  }

  void _navigateToAddEvent() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventAdder(
                  fnAddEvent: _upsertEvent,
                  oldEvent: _newEvent(),
                )));
  }

  Event _newEvent() {
    return Event(
        id: -1,
        name: "",
        description: "",
        from: DateTime.now().roundUp(delta: const Duration(minutes: 60)),
        to: DateTime.now()
            .roundUp(delta: const Duration(minutes: 60))
            .add(const Duration(minutes: 60)),
        tags: List.empty(),
        place: "",
        imagePath: "");
  }

  void _upsertEvent(Event newEvent) async {
    var response = await EventStore().upsert(newEvent,
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
