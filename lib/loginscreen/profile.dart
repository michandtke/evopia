import 'package:evopia/tags/tag.dart';
import 'package:json_annotation/json_annotation.dart';

import '../profilescreen/channel.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  final String imagePath;
  final List<Tag> tags;
  final List<Channel> profileChannels;

  Profile(
      {required this.imagePath,
      required this.tags,
      required this.profileChannels});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
