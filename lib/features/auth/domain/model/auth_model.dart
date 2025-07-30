class AuthModel {
  String message;
  UserModel user;
  String? token;

  AuthModel({
    required this.message,
    required this.user,
    this.token,
  });
}

class UserModel {
  String id;
  String name;
  String email;
  String phone;
  String country;
  String city;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic profileImage;
  String username;

  UserModel({
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
}
