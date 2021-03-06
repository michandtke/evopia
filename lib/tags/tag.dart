import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag extends Equatable {
  final String name;

  const Tag({ required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() {
    return name;
  }

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}