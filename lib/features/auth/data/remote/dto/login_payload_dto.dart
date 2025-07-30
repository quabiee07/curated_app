// To parse this JSON data, do
//
//     final loginPayloadDto = loginPayloadDtoFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'login_payload_dto.g.dart';

LoginPayloadDto loginPayloadDtoFromJson(String str) => LoginPayloadDto.fromJson(json.decode(str));

String loginPayloadDtoToJson(LoginPayloadDto data) => json.encode(data.toJson());

@JsonSerializable()
class LoginPayloadDto {
    @JsonKey(name: "email")
    String email;
    @JsonKey(name: "password")
    String password;

    LoginPayloadDto({
        required this.email,
        required this.password,
    });

    factory LoginPayloadDto.fromJson(Map<String, dynamic> json) => _$LoginPayloadDtoFromJson(json);

    Map<String, dynamic> toJson() => _$LoginPayloadDtoToJson(this);
}
