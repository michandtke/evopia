import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventImage extends StatelessWidget {

  final String path;
  final double? height;

  const EventImage({Key? key, required this.path, this.height}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(path, height: height);
  }
}