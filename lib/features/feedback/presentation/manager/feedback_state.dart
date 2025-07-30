import 'package:curated_app/features/feedback/domain/model/payload/feedback_payload.dart';

class FeedbackState {
  String message = '';
  String? messageError;

  String rating = '';
  String? ratingError;
  Map<int, FeedbackType> ratings = {
    1: FeedbackType.happy,
    2: FeedbackType.neutral,
    3: FeedbackType.sad,
  };

  FeedbackPayload toPayload() {
    return FeedbackPayload(
        message: message,
        rating: ratings.keys
            .firstWhere((key) => ratings[key] == FeedbackType.happy));
  }
}

enum FeedbackType { happy, neutral, sad }
