import 'package:curated_app/core/di/core_module_container.dart';
import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/core/domain/utils/utils.dart';
import 'package:curated_app/core/presentation/utils/utils.dart';
import 'package:curated_app/features/profile/data/remote/services/profile_api_service.dart';
import 'package:curated_app/features/profile/domain/model/payload/update_user_payload.dart';
import 'package:curated_app/features/profile/domain/model/profile.dart';
import 'package:curated_app/features/profile/domain/repository/profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final api = getIt.get<ProfileApiService>();

  @override
  Future<ApiResult<Profile>> getUser() async {
    try {
      final result = await api.getUserProfile(token: accessToken);
      return ApiResult.success(result.user.toDto());
    } catch (e) {
      return ApiResult.failure('Failed to get user profile: $e');
    }
  }

  @override
  Future<ApiResult<Profile>> updateUser(UpdateUserPayload payload) async {
    try {
         final files = <MultipartFile>[];
    for (final file in payload.profileImage) {
      if (kIsWeb) {
        // Handle web file upload (e.g., using bytes or XFile)
        // Convert to MultipartFile from bytes
        final fileBytes = await file.readAsBytes();
        final multipartFile = MultipartFile.fromBytes(
          fileBytes, // assuming you have bytes
          filename: file.path.split('/').last,
          contentType: getContentType(file.path),
        );
        files.add(multipartFile);
      } else {
        //this checks if the file exists before conversion

        final multipartFile = MultipartFile.fromFileSync(
          file.path,
          filename: file.path.split('/').last,
          contentType: getContentType(file.path),
        );
        files.add(multipartFile);
      }
    }
      final result = await api.updateUser(
        token: accessToken,
        name: payload.name,
        email: payload.email,
        profileImage: files,
      );
      return ApiResult.success(result.user.toDto());
    } catch (e) {
      return ApiResult.failure('Failed to update profile: $e');
    }
  }
}
