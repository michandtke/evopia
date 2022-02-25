import 'package:flutter/material.dart';

import '../picker.dart';
import 'event_image.dart';

class PickableImage extends StatelessWidget {
  final String? imagePath;
  final void Function(String?) onImagePick;

  const PickableImage(
      {Key? key, required this.imagePath, required this.onImagePick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _pickable(context);
  }

  Widget _pickable(BuildContext context) {
    return InkWell(child: _image(), onTap: () => pickImage(context));
  }

  Widget _image() {
    var path = imagePath;
    if (path != null && path.isNotEmpty) {
      return EventImage(path: path);
    }
    return const SizedBox(
        height: 100, child: Text("Click here to pick an image"));
  }

  void pickImage(BuildContext context) async {
    String? imagePath = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Picker(prefix: 'assets/icons')));
    onImagePick(imagePath);
  }
}
