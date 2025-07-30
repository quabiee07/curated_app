// To parse this JSON data, do
//
//     final createdPostDto = createdPostDtoFromJson(jsonString);

import 'package:curated_app/features/post/domain/model/created_post_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'created_post_dto.g.dart';

CreatedPostDto createdPostDtoFromJson(String str) =>
    CreatedPostDto.fromJson(json.decode(str));

String createdPostDtoToJson(CreatedPostDto data) => json.encode(data.toJson());

@JsonSerializable()
class CreatedPostDto {
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "data")
  Data data;

  CreatedPostDto({
    required this.message,
    required this.data,
  });

  factory CreatedPostDto.fromJson(Map<String, dynamic> json) =>
      _$CreatedPostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedPostDtoToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "user_id")
  String userId;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "url")
  String url;
  @JsonKey(name: "image")
  String image;
  @JsonKey(name: "description")
  String description;

  Data({
    required this.id,
    required this.userId,
    required this.title,
    required this.url,
    required this.image,
    required this.description,
  });

  CreatedPost toDto() {
    return CreatedPost(
      id: id,
      userId: userId,
      title: title,
      url: url,
      image: image,
      description: description,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
