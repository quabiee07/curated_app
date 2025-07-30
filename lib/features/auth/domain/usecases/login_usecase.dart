import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/core/domain/use_case/use_case.dart';
import 'package:curated_app/features/auth/domain/model/auth_model.dart';
import 'package:curated_app/features/auth/domain/model/login_payload.dart';
import 'package:curated_app/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase extends UseCase<AuthModel, LoginPayload> {
  late AuthRepository repo;
  LoginUsecase(super.param, this.repo);

  @override
  Future<ApiResult<AuthModel>> invoke() {
    return repo.login(param);
  }
}
