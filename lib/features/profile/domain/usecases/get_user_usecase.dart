import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/core/domain/use_case/use_case.dart';
import 'package:curated_app/features/profile/domain/model/profile.dart';
import 'package:curated_app/features/profile/domain/repository/profile_repository.dart';

class GetProfileUsecase extends UseCase<Profile, void> {
  final ProfileRepository repository;

  GetProfileUsecase(this.repository, super.param);

  @override
  Future<ApiResult<Profile>> invoke() {
    return repository.getUser();
  }
}
