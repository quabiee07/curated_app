import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/features/auth/domain/model/auth_model.dart';
import 'package:curated_app/features/auth/domain/model/login_payload.dart';
import 'package:curated_app/features/auth/domain/model/register_payload.dart';

abstract class AuthRepository {
  Future<ApiResult<AuthModel>> login(LoginPayload param);
  Future<ApiResult<AuthModel>> register(RegisterPayload param);
}
