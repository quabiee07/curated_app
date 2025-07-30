// To parse this JSON data, do
//
//     final createdPostPayloadDto = createdPostPayloadDtoFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'created_post_payload_dto.g.dart';

CreatedPostPayloadDto createdPostPayloadDtoFromJson(String str) =>
    CreatedPostPayloadDto.fromJson(json.decode(str));

String createdPostPayloadDtoToJson(CreatedPostPayloadDto data) =>
    json.encode(data.toJson());

@JsonSerializable()
class CreatedPostPayloadDto {
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "url")
  String url;
  @JsonKey(name: "image")
  String image;
  @JsonKey(name: "description")
  String description;

  CreatedPostPayloadDto({
    required this.title,
    required this.url,
    required this.image,
    required this.description,
  });

  factory CreatedPostPayloadDto.fromJson(Map<String, dynamic> json) =>
      _$CreatedPostPayloadDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedPostPayloadDtoToJson(this);
}
