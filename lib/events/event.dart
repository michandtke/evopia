import 'package:equatable/equatable.dart';
import 'package:evopia/tags/tag.dart';

class Event extends Equatable {
  final int id;
  final String name;
  final String description;
  final DateTime from;
  final DateTime to;
  final String place;
  final String image;
  final List<Tag> tags;

  Event(
      {required this.id,
      required this.name,
      required this.description,
      required this.from,
      required this.to,
      required this.tags,
      required this.place,
      required this.image});

  Event copyWithoutId() {
    return Event(
        id: -1,
        name: name,
        description: description,
        from: from,
        to: to,
        place: place,
        image: image,
        tags: tags);
  }

  Event copy({newName, newPlace, newDescription, newTags}) {
    return Event(
        id: id,
        name: newName ?? name,
        description: newDescription ?? description,
        from: from,
        to: to,
        place: newPlace ?? place,
        image: image,
        tags: newTags ?? tags);
  }

  @override
  List<Object> get props => [id, name, description, from, to, tags, place, image];
}
