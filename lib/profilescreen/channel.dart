import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'channel.g.dart';

@JsonSerializable()
class Channel extends Equatable {
  final String name;
  final String value;

  const Channel({ required this.name, required this.value});

  @override
  List<Object> get props => [name, value];


  @override
  String toString() {
    return 'Channel{name: $name, value: $value}';
  }

  factory Channel.fromJson(Map<String, dynamic> json) => _$ChannelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelToJson(this);
}