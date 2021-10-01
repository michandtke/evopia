import 'package:evopia/event_list.dart';
import 'package:flutter/material.dart';

import 'event.dart';
import 'event_adder.dart';
import 'event_store.dart';

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
      home: const MyHomePage(title: 'Events'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Event>> eventsFuture = EventStore().get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return EventList(events: snapshot.data as List<Event>);
          }
          if (snapshot.hasError) return Text("${snapshot.error}");
          return const CircularProgressIndicator();
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddEvent,
        tooltip: 'Add event',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddEvent() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EventAdder(fnAddEvent: _addEvent)));
  }

  void _addEvent(Event newEvent) async {
    await EventStore().add(newEvent);
    setState(() {});
  }
}
