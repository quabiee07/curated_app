import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/features/profile/domain/model/payload/update_user_payload.dart';
import 'package:curated_app/features/profile/domain/model/profile.dart';

abstract class ProfileRepository {
  Future<ApiResult<Profile>> getUser();
  Future<ApiResult<Profile>> updateUser(UpdateUserPayload payload);
}
