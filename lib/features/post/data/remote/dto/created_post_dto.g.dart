// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'created_post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatedPostDto _$CreatedPostDtoFromJson(Map<String, dynamic> json) =>
    CreatedPostDto(
      message: json['message'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreatedPostDtoToJson(CreatedPostDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'url': instance.url,
      'image': instance.image,
      'description': instance.description,
    };
