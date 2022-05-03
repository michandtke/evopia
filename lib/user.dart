import 'package:equatable/equatable.dart';
import 'package:evopia/profilescreen/channel.dart';
import 'package:evopia/tags/tag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final String imagePath;

  const User(
      {required this.imagePath,
      required this.email,
      required this.firstName,
      required this.lastName});

  @override
  List<Object> get props => [imagePath, email, firstName, lastName];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
