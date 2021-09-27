import 'package:flutter/material.dart';

class TagEntry extends StatelessWidget {
  final String name;

  const TagEntry({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildTag();
  }

  Widget buildTag() {
    return Container(
        padding:const EdgeInsets.all(4.0),
        child: Text(name),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.grey.shade200
        ));
  }
}