// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewProfile _$NewProfileFromJson(Map<String, dynamic> json) => NewProfile(
      image: json['image'] as String,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      channels: (json['channels'] as List<dynamic>)
          .map((e) => Channel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewProfileToJson(NewProfile instance) =>
    <String, dynamic>{
      'image': instance.image,
      'tags': instance.tags,
      'channels': instance.channels,
    };
