// To parse this JSON data, do
//
//     final homePostDto = homePostDtoFromJson(jsonString);

import 'package:curated_app/features/home/domain/model/post.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'home_post_dto.g.dart';

HomePostDto homePostDtoFromJson(String str) =>
    HomePostDto.fromJson(json.decode(str));

String homePostDtoToJson(HomePostDto data) => json.encode(data.toJson());

@JsonSerializable()
class HomePostDto {
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "data")
  Data data;

  HomePostDto({
    required this.message,
    required this.data,
  });

  factory HomePostDto.fromJson(Map<String, dynamic> json) =>
      _$HomePostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HomePostDtoToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "current_page")
  int currentPage;
  @JsonKey(name: "data")
  List<HomePostDataDto> data;
  @JsonKey(name: "total")
  int total;
  @JsonKey(name: "last_page")
  int lastPage;

  Data({
    required this.currentPage,
    required this.data,
    required this.total,
    required this.lastPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  HomePostData toDto() {
    return HomePostData(
        currentPage: currentPage,
        data: data.map((e) => e.toDto()).toList(),
        total: total,
        lastPage: lastPage);
  }
}

@JsonSerializable()
class HomePostDataDto {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "user_id")
  String userId;
  @JsonKey(name: "url")
  String url;
  @JsonKey(name: "image")
  String image;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "user")
  User user;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;

  HomePostDataDto({
    required this.id,
    required this.title,
    required this.user,
    required this.userId,
    required this.url,
    required this.image,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });
  PostModel toDto() {
    return PostModel(
        id: id,
        title: title,
        userId: userId,
        image: image,
        url: url,
        description: description,
        user: user.toDto(),
        createdAt: createdAt,
        updatedAt: updatedAt);
  }

  factory HomePostDataDto.fromJson(Map<String, dynamic> json) =>
      _$HomePostDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HomePostDataDtoToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "profile_image")
  String? profileImage;

  User({
    required this.id,
    required this.name,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  PostUser toDto() {
    return PostUser(id: id, name: name, profileImage: profileImage);
  }
}
