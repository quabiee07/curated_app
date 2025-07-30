import 'dart:convert';
import 'package:curated_app/core/di/core_module_container.dart';
import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/core/domain/utils/utils.dart';
import 'package:curated_app/features/auth/application/auth_service.dart';
import 'package:curated_app/features/auth/data/remote/dto/login_payload_dto.dart';
import 'package:curated_app/features/auth/data/remote/dto/register_payload_dto.dart';
import 'package:curated_app/features/auth/data/remote/services/auth_api_service.dart';
import 'package:curated_app/features/auth/domain/model/auth_model.dart';
import 'package:curated_app/features/auth/domain/model/login_payload.dart';
import 'package:curated_app/features/auth/domain/model/register_payload.dart';
import 'package:curated_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final api = getIt.get<AuthApiService>();
  final _pref = getIt.getAsync<SharedPreferences>();
  final authService = getIt<AuthService>();

  @override
  Future<ApiResult<AuthModel>> login(LoginPayload param) async {
    try {
      final pref = await _pref;
      final payload =
          LoginPayloadDto(email: param.email, password: param.password);
      final result = await api.login(payload: payload);
      pref.setString(tokenKey, result.token!);
      pref.setString(user, json.encode(result.user));
      accessToken = "Bearer ${result.token}";
      authService.login(accessToken, json.encode(result.user));

      return ApiResult.success(result.toDto());
    } catch (error) {
      return ApiResult.failure(error);
    }
  }

  @override
  Future<ApiResult<AuthModel>> register(RegisterPayload param) async {
    try {
      final payload = RegisterPayloadDto(
        name: param.name,
        email: param.email,
        phone: param.phone,
        password: param.password,
        passwordConfirmation: param.passwordConfirmation,
        country: param.country,
        city: param.city,
        username: param.username,
      );

      final result = await api.register(payload: payload);
      return ApiResult.success(result.toDto());
    } catch (error) {
      return ApiResult.failure(error);
    }
  }
}
