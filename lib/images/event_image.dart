import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class EventImage extends StatelessWidget {

  final String path;
  final double? height;

  const EventImage({Key? key, required this.path, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) {
      return Container();
    }
    if (path.contains("svg")) {
      return SvgPicture.asset(path, height: height);
    }
    if (path.contains("png")) {
      return Image.asset(path, height: height);
    }
    return Text("Nothing hit :/ " + path);
  }

  PictureProvider x() {
    return SvgPicture.asset(path).pictureProvider;
  }
}