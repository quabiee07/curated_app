import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/features/feedback/domain/model/feedback_model.dart';
import 'package:curated_app/features/feedback/domain/model/payload/feedback_payload.dart';

abstract class FeedbackRepository {
  Future<ApiResult<FeedbackModel>> sendFeedback(FeedbackPayload payload);
}
