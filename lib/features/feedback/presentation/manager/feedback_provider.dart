import 'package:curated_app/core/di/core_module_container.dart';
import 'package:curated_app/core/domain/validation/validation.dart';
import 'package:curated_app/core/presentation/manager/custom_provider.dart';
import 'package:curated_app/features/feedback/domain/repository/feedback_repository.dart';
import 'package:curated_app/features/feedback/domain/usecases/send_feedback_usecase.dart';
import 'package:curated_app/features/feedback/presentation/manager/feedback_state.dart';

class FeedbackProvider extends CustomProvider {
  final state = FeedbackState();
  final _repo = getIt.get<FeedbackRepository>();

  setMessage(String message) {
    state.message = message;
    state.messageError = message.validateField();
    notifyListeners();
  }

  setFeedbackType(dynamic type) {
    notifyListeners();
  }

  sendFeedback() {
    onLoad();

    SendFeedbackUsecase(param: state.toPayload(), repository: _repo)
        .invoke()
        .then((value) {
      final result = value.getOrElse((error) {
        add(error);
        return null;
      });
      if (result != null) {
        add(result);
      }
      onLoad();
    });
  }
}
