import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/core/domain/use_case/use_case.dart';
import 'package:curated_app/features/feedback/domain/model/feedback_model.dart';
import 'package:curated_app/features/feedback/domain/model/payload/feedback_payload.dart';
import 'package:curated_app/features/feedback/domain/repository/feedback_repository.dart';

class SendFeedbackUsecase implements UseCase<FeedbackModel, FeedbackPayload> {
  late FeedbackRepository repository;
  SendFeedbackUsecase({required this.param, required this.repository});
  @override
  Future<ApiResult<FeedbackModel>> invoke() {
    return repository.sendFeedback(param);
  }

  @override
  FeedbackPayload param;
}
