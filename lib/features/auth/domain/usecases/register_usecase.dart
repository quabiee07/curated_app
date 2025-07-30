import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/core/domain/use_case/use_case.dart';
import 'package:curated_app/features/auth/domain/model/auth_model.dart';
import 'package:curated_app/features/auth/domain/model/register_payload.dart';
import 'package:curated_app/features/auth/domain/repository/auth_repository.dart';

class RegisterUsecase extends UseCase<AuthModel, RegisterPayload> {
  late AuthRepository repo;
  RegisterUsecase(super.param, this.repo);

  @override
  Future<ApiResult<AuthModel>> invoke() {
    return repo.register(param);
  }
}
