import 'package:curated_app/features/auth/domain/model/login_payload.dart';
import 'package:curated_app/features/auth/domain/model/register_payload.dart';

class AuthState {
  bool isBasic = false;
  bool hasAgreedToTerms = false;
  String email = '';
  String? emailError;
  String password = '';
  String? passwordError;
  String confirmPassword = '';
  String? confirmPasswordError;
  String oldPassword = '';
  String? oldPasswordError;
  String phone = '';
  String? phoneError;
  String firstName = '';
  String? firstNameError;
  String lastName = '';
  String? lastNameError;
  String city = '';
  String? cityError;
  String username = '';
  String? usernameError;

  String code = '';
  String country= '';
  String? countryError;

  String countryCode = '';
  String countryFlag = '';

  LoginPayload loginInfo() {
    return LoginPayload(email: email, password: password);
  }

  RegisterPayload registerInfo() {
    return RegisterPayload(
      name: '$firstName $lastName',
      email: email,
      phone: phone,
      password: password,
      passwordConfirmation: confirmPassword,
      country: country,
      city: city,
      username: username,
    );
  }
}
