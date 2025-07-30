// To parse this JSON data, do
//
//     final registerDto = registerDtoFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'register_dto.g.dart';

RegisterDto registerDtoFromJson(String str) => RegisterDto.fromJson(json.decode(str));

String registerDtoToJson(RegisterDto data) => json.encode(data.toJson());

@JsonSerializable()
class RegisterDto {
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "user")
    User user;

    RegisterDto({
        required this.message,
        required this.user,
    });

    factory RegisterDto.fromJson(Map<String, dynamic> json) => _$RegisterDtoFromJson(json);

    Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);
}

@JsonSerializable()
class User {
    @JsonKey(name: "id")
    int id;
    @JsonKey(name: "name")
    String name;
    @JsonKey(name: "email")
    String email;
    @JsonKey(name: "username")
    String username;
    @JsonKey(name: "phone")
    String phone;
    @JsonKey(name: "country")
    String country;
    @JsonKey(name: "city")
    String city;
    @JsonKey(name: "created_at")
    DateTime createdAt;
    @JsonKey(name: "updated_at")
    DateTime updatedAt;

    User({
        required this.id,
        required this.name,
        required this.email,
        required this.username,
        required this.phone,
        required this.country,
        required this.city,
        required this.createdAt,
        required this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

    Map<String, dynamic> toJson() => _$UserToJson(this);
}
