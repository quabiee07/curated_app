// To parse this JSON data, do
//
//     final profileDto = profileDtoFromJson(jsonString);

import 'package:curated_app/features/profile/domain/model/profile.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'profile_dto.g.dart';

ProfileDto profileDtoFromJson(String str) =>
    ProfileDto.fromJson(json.decode(str));

String profileDtoToJson(ProfileDto data) => json.encode(data.toJson());

@JsonSerializable()
class ProfileDto {
  @JsonKey(name: "user")
  ProfileDataDto user;

  ProfileDto({
    required this.user,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);
}

@JsonSerializable()
class ProfileDataDto {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "phone")
  String phone;
  @JsonKey(name: "country")
  String country;
  @JsonKey(name: "city")
  String city;
  @JsonKey(name: "bio")
  String? bio;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;
  @JsonKey(name: "profile_image")
  dynamic profileImage;
  @JsonKey(name: "username")
  String username;

  ProfileDataDto({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.city,
    required this.bio,
    required this.createdAt,
    required this.updatedAt,
    required this.profileImage,
    required this.username,
  });

  Profile toDto() {
    return Profile(
      id: id,
      name: name,
      email: email,
      phone: phone,
      country: country,
      city: city,
      createdAt: createdAt,
      updatedAt: updatedAt,
      profileImage: profileImage,
      username: username,
      bio: bio,
    );
  }

  factory ProfileDataDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataDtoToJson(this);
}
