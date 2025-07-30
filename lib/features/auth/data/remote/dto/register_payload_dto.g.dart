// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_payload_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterPayloadDto _$RegisterPayloadDtoFromJson(Map<String, dynamic> json) =>
    RegisterPayloadDto(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['password_confirmation'] as String,
      phone: json['phone'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$RegisterPayloadDtoToJson(RegisterPayloadDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
      'phone': instance.phone,
      'country': instance.country,
      'city': instance.city,
      'username': instance.username,
    };
