class RegisterPayload {
  final String name;
  final String email;
  final String phone;
  final String country;
  final String city;
  final String username;
  final String password;
  final String passwordConfirmation;

  RegisterPayload({
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.city,
    required this.username,
    required this.password,
    required this.passwordConfirmation,
  });
}
