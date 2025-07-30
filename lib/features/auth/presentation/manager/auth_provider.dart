import 'package:country_picker/country_picker.dart';
import 'package:curated_app/core/di/core_module_container.dart';
import 'package:curated_app/core/domain/utils/utils.dart';
import 'package:curated_app/core/domain/validation/validation.dart';
import 'package:curated_app/core/presentation/manager/custom_provider.dart';
import 'package:curated_app/features/auth/application/auth_service.dart';
import 'package:curated_app/features/auth/domain/repository/auth_repository.dart';
import 'package:curated_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:curated_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:curated_app/features/auth/presentation/manager/auth_state.dart'as auth;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends CustomProvider {
  var state = auth.AuthState();
  final _repo = getIt.get<AuthRepository>();
  final _pref = getIt.getAsync<SharedPreferences>();
  final AuthService _authService = getIt.get<AuthService>();

  setToggle(bool value) {
    state.hasAgreedToTerms = value;
    _validateBasic();
  }

  setEmail(String email) {
    state.email = email;
    state.emailError = email.validateEmail();
    _validateBasic();
  }

  setFirstName(String firstName) {
    state.firstName = firstName;
    state.firstNameError = firstName.validateName();
    _validateBasic();
  }

  setLastName(String lastName) {
    state.lastName = lastName;
    state.lastNameError = lastName.validateName();
    _validateBasic();
  }

  setPhone(String phone) {
    state.phone = phone;
    state.phoneError = phone.validatePhone();
    _validateBasic();
  }

  setPassword(String password) {
    state.password = password;
    state.passwordError = password.validatePassword();
    _validateBasic();
  }

  setConfirmPassword(String confirmPassword) {
    state.confirmPassword = confirmPassword;
    state.confirmPasswordError =
        confirmPassword.validateRePassword(state.password);
    _validateBasic();
  }

  setCity(String city) {
    state.city = city;
    state.cityError = city.validateName();
    _validateBasic();
  }

  setCountry(Country country) {
    state.country = country.name;
    state.countryCode = country.phoneCode;
    state.countryFlag = country.flagEmoji;
    state.countryError = country.name.validateName();
    _validateBasic();
  }

  setUsername(String username) {
    state.username = username;
    state.usernameError = username.validateName();
    _validateBasic();
  }

  _validateBasic() {
    state.isBasic = [
      state.firstName.validateField() == null,
      state.lastName.validateField() == null,
      state.phone.validateField() == null,
      state.password.validateField() == null,
      state.confirmPassword.validateField() == null,
      state.city.validateField() == null,
      state.username.validateField() == null,
      state.email.validateField() == null,
      state.country.validateField() == null,
      state.hasAgreedToTerms == true,
    ].validate();
    notifyListeners();
  }

  register() {
    onLoad();

    RegisterUsecase(state.registerInfo(), _repo).invoke().then((value) {
      final result = value.getOrElse((error) {
        add(error);
        return null;
      });

      if (result != null) {
        add(result);
      }
      onLoad();
    });
  }

  login() {
    onLoad();
    LoginUsecase(state.loginInfo(), _repo).invoke().then((value) {
      final result = value.getOrElse((error) {
        add(error);
        return null;
      });

      if (result != null) {
        add(result);
      }
      onLoad();
    });
  }

  logout() {
    _pref.then((prefs) {
      prefs.remove(tokenKey);
      prefs.remove(user);
    });
    accessToken = '';
    _authService.logout();

  }
}
