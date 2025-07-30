import 'package:curated_app/features/auth/domain/model/auth_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_dto.g.dart';

@JsonSerializable()
class AuthDto {
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "user")
  UserDto user;
  @JsonKey(name: "token")
  String? token;

  AuthDto({
    required this.message,
    required this.user,
    this.token,
  });

  AuthModel toDto() {
    return AuthModel(
      message: message,
      user: user.toDto(),
      token: token,
    );
  }

  factory AuthDto.fromJson(Map<String, dynamic> json) =>
      _$AuthDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDtoToJson(this);
}

@JsonSerializable()
class UserDto {
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
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;
  @JsonKey(name: "profile_image")
  dynamic profileImage;
  @JsonKey(name: "username")
  String username;

  UserDto({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
    required this.profileImage,
    required this.username,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserModel toDto() {
    return UserModel(
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
    );
  }
}
