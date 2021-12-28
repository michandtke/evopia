import 'dart:convert';

import 'package:flutter/material.dart';

import 'images/event_image.dart';

class Picker extends StatelessWidget {
  final String prefix;

  const Picker({Key? key, required this.prefix}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(top: 50, left: 10),
            child: FutureBuilder(
                future: assets(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return assetList(context, snapshot.data as List<String>);
                  }
                  if (snapshot.hasError) {
                    return Text("Unfortunately, an error: ${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
                })));
  }

  Future<List<String>> assets(BuildContext context) async {
    final manifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    print(manifestJson);
    List<String> images = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith(prefix))
        .toList();
    return images;
  }

  Widget assetList(BuildContext context, List<String> paths) {
    return Wrap(children: paths.map((path) => toImage(context, path)).toList());
  }

  Widget toImage(BuildContext context, String path) {
    return MaterialButton(
        onPressed: () => Navigator.pop(context, path),
        child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: EventImage(path: path)));
  }
}
