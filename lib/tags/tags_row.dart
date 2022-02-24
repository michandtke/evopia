import 'package:evopia/tags/tag_provider.dart';
import 'package:flutter/material.dart';

import 'tag.dart';

class TagsRow extends StatelessWidget {
  final void Function(Tag tag) addTag;
  final void Function(Tag tag) removeTag;
  final List<Tag> tags;
  final bool editMode;

  const TagsRow(
      {Key? key,
      required this.tags,
      required this.addTag,
      required this.removeTag,
      required this.editMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _tags();
  }

  Widget _tags() {
    var tags = editMode ? editModeTags() : showModeTags();
    return Wrap(spacing: 8.0, runSpacing: 4.0, children: tags);
  }

  List<Widget> showModeTags() {
    return tags.map(showTag).toList();
  }

  Chip showTag(Tag tag) {
    return Chip(label: Text(tag.name));
  }

  List<Widget> editModeTags() {
    List<Widget> tagChips = tags.map(removableTag).toList();
    return [...tagChips, newTag(tags)];
  }

  InputChip removableTag(Tag tag) {
    return InputChip(
        avatar: const Icon(Icons.remove),
        label: Text(tag.name),
        onSelected: (sel) {
          if (sel) {
            removeTag(tag);
          }
        });
  }

  Widget newTag(List<Tag> tagsAlreadyAssigned) {
    var tags = TagProvider()
        .provide()
        .where((element) => !tagsAlreadyAssigned.contains(element));
    return DropdownButton<Tag>(
      hint: const Chip(label: Icon(Icons.add_sharp)),
      icon: Container(),
      underline: Container(),
      items: tags
          .map(
              (tag) => DropdownMenuItem<Tag>(value: tag, child: Text(tag.name)))
          .toList(),
      onChanged: (tag) {
        if (tag != null) {
          addTag(tag);
        }
      },
    );
  }
}
