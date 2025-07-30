import 'package:curated_app/features/feedback/data/remote/dto/feedback_dto.dart';
import 'package:curated_app/features/feedback/data/remote/dto/feedback_payload_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'feedback_api_service.g.dart';

@RestApi(baseUrl: 'https://api.curated.forum/api/v1/')
abstract class FeedbackApiService {
  factory FeedbackApiService(Dio dio, {String baseUrl}) = _FeedbackApiService;

  static const authentication = 'Authorization';

  @POST('feedback')
  Future<FeedbackDto> sendFeedback({
    @Header(authentication) required String token,
    @Body() required FeedbackPayloadDto payload,       
  });
}
