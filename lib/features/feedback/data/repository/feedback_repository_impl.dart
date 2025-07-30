import 'package:curated_app/core/di/core_module_container.dart';
import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/core/domain/utils/utils.dart';
import 'package:curated_app/features/feedback/data/remote/dto/feedback_payload_dto.dart';
import 'package:curated_app/features/feedback/data/remote/service/feedback_api_service.dart';
import 'package:curated_app/features/feedback/domain/model/feedback_model.dart';
import 'package:curated_app/features/feedback/domain/model/payload/feedback_payload.dart';
import 'package:curated_app/features/feedback/domain/repository/feedback_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FeedbackRepository)
class FeedbackRepositoryImpl implements FeedbackRepository {
  final api = getIt.get<FeedbackApiService>();
  @override
  Future<ApiResult<FeedbackModel>> sendFeedback(FeedbackPayload payload) async {
    try {
      final params =
          FeedbackPayloadDto(message: payload.message, rating: payload.rating);
      final result = await api.sendFeedback(
        token: accessToken,
        payload: params,
      );
      return ApiResult.success(result.data.toModel());
    } catch (e) {
      return ApiResult.failure(e);
    }
  }
}
