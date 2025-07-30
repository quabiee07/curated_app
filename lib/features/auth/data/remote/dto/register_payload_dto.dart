// To parse this JSON data, do
//
//     final registerPayloadDto = registerPayloadDtoFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'register_payload_dto.g.dart';

RegisterPayloadDto registerPayloadDtoFromJson(String str) => RegisterPayloadDto.fromJson(json.decode(str));

String registerPayloadDtoToJson(RegisterPayloadDto data) => json.encode(data.toJson());

@JsonSerializable()
class RegisterPayloadDto {
    @JsonKey(name: "name")
    String name;
    @JsonKey(name: "email")
    String email;
    @JsonKey(name: "password")
    String password;
    @JsonKey(name: "password_confirmation")
    String passwordConfirmation;
    @JsonKey(name: "phone")
    String phone;
    @JsonKey(name: "country")
    String country;
    @JsonKey(name: "city")
    String city;
    @JsonKey(name: "username")
    String username;

    RegisterPayloadDto({
        required this.name,
        required this.email,
        required this.password,
        required this.passwordConfirmation,
        required this.phone,
        required this.country,
        required this.city,
        required this.username,
    });

    factory RegisterPayloadDto.fromJson(Map<String, dynamic> json) => _$RegisterPayloadDtoFromJson(json);

    Map<String, dynamic> toJson() => _$RegisterPayloadDtoToJson(this);
}
