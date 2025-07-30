// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePostDto _$HomePostDtoFromJson(Map<String, dynamic> json) => HomePostDto(
      message: json['message'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomePostDtoToJson(HomePostDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      currentPage: (json['current_page'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => HomePostDataDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      lastPage: (json['last_page'] as num).toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'total': instance.total,
      'last_page': instance.lastPage,
    };

HomePostDataDto _$HomePostDataDtoFromJson(Map<String, dynamic> json) =>
    HomePostDataDto(
      id: json['id'] as String,
      title: json['title'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      userId: json['user_id'] as String,
      url: json['url'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$HomePostDataDtoToJson(HomePostDataDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'user_id': instance.userId,
      'url': instance.url,
      'image': instance.image,
      'description': instance.description,
      'user': instance.user,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      name: json['name'] as String,
      profileImage: json['profile_image'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_image': instance.profileImage,
    };
