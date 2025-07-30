import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/core/domain/use_case/use_case.dart';
import 'package:curated_app/features/profile/domain/model/payload/update_user_payload.dart';
import 'package:curated_app/features/profile/domain/model/profile.dart';
import 'package:curated_app/features/profile/domain/repository/profile_repository.dart';

class UpdateUserUsecase extends UseCase<Profile, UpdateUserPayload> {
  final ProfileRepository repository;

  UpdateUserUsecase(this.repository, super.param);

  @override
  Future<ApiResult<Profile>> invoke() {
    return repository.updateUser(param);
  }
}
 