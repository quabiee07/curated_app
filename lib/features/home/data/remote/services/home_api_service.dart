import 'package:curated_app/features/home/data/remote/dto/home_post_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'home_api_service.g.dart';

@RestApi(baseUrl: 'https://api.curated.forum/api/v1/')
abstract class HomeApiService {
  factory HomeApiService(Dio dio, {String baseUrl}) = _HomeApiService;

  static const authentication = 'Authorization';

  @GET('homepage-posts')
  Future<HomePostDto> getHomePagePosts({
    @Header(authentication) required String token,
    // @Query('per_page') required int page,
    // @Query('page') required int limit,
  });
}
