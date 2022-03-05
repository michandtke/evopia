import 'package:evopia/tags/tag.dart';
import 'package:json_annotation/json_annotation.dart';

import '../profilescreen/channel.dart';

part 'new_profile.g.dart';

@JsonSerializable()
class NewProfile {
  final String image;
  final List<Tag> tags;
  final List<Channel> profileChannels;

  NewProfile(
      {required this.image,
      required this.tags,
      required this.profileChannels});

  factory NewProfile.fromJson(Map<String, dynamic> json) =>
      _$NewProfileFromJson(json);

  Map<String, dynamic> toJson() => _$NewProfileToJson(this);
}
