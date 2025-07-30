import 'package:curated_app/features/profile/data/remote/dto/profile_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'profile_api_service.g.dart';

@RestApi(baseUrl: 'https://api.curated.forum/api/v1/')
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio, {String baseUrl}) = _ProfileApiService;

  static const authentication = 'Authorization';

  @PUT('user')
  @MultiPart()
  Future<ProfileDto> updateUser({
    @Header(authentication) required String token,
    @Part(name: 'name') required String name,
    @Part(name: 'email') required String email,
    @Part(name: 'profile_image') required List<MultipartFile> profileImage,
  });

  @GET('user')
  Future<ProfileDto> getUserProfile(
      {@Header(authentication) required String token});
}
