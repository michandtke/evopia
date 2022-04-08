import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'channel.g.dart';

@JsonSerializable()
class Channel extends Equatable {
  final String name;

  const Channel({ required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() {
    return name;
  }

  factory Channel.fromJson(Map<String, dynamic> json) => _$ChannelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelToJson(this);
}