import 'package:equatable/equatable.dart';
import 'package:evopia/tags/tag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event extends Equatable {
  final int id;
  final String name;
  final String description;
  final DateTime from;
  final DateTime to;
  final String place;
  final String imagePath;
  final List<Tag> tags;

  Event(
      {required this.id,
      required this.name,
      required this.description,
      required this.from,
      required this.to,
      required this.tags,
      required this.place,
      required this.imagePath});

  Event copyWithoutId() {
    return Event(
        id: -1,
        name: name,
        description: description,
        from: from,
        to: to,
        place: place,
        imagePath: imagePath,
        tags: tags);
  }

  Event copy(
      {newName,
      newPlace,
      newDescription,
      newTags,
      newImagePath,
      newFrom,
      newTo}) {
    return Event(
        id: id,
        name: newName ?? name,
        description: newDescription ?? description,
        from: newFrom ?? from,
        to: newTo ?? to,
        place: newPlace ?? place,
        imagePath: newImagePath ?? imagePath,
        tags: newTags ?? tags);
  }

  @override
  List<Object> get props =>
      [id, name, description, from, to, tags, place, imagePath];


  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
