
import 'package:equatable/equatable.dart';
import 'package:evopia/profilescreen/channel.dart';
import 'package:evopia/tags/tag.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable{

  final String imagePath;
  final List<Tag> tags;
  final List<Channel> profileChannels;

  User(
      {required this.imagePath,
        required this.tags,
        required this.profileChannels});


  @override
  List<Object> get props => [imagePath, tags, profileChannels];

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}