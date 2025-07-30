// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'created_post_payload_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatedPostPayloadDto _$CreatedPostPayloadDtoFromJson(
        Map<String, dynamic> json) =>
    CreatedPostPayloadDto(
      title: json['title'] as String,
      url: json['url'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$CreatedPostPayloadDtoToJson(
        CreatedPostPayloadDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'image': instance.image,
      'description': instance.description,
    };
