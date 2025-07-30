
import 'package:curated_app/features/post/data/remote/dto/created_post_dto.dart';
import 'package:curated_app/features/post/data/remote/dto/created_post_payload_dto.dart';
import 'package:curated_app/features/post/data/remote/dto/post_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'post_api_service.g.dart';

@RestApi(baseUrl: 'https://api.curated.forum/api/v1/')
abstract class PostApiService {
  factory PostApiService(Dio dio, {String baseUrl}) = _PostApiService;

  static const authentication = 'Authorization';

  @POST('post')
  @MultiPart()
  Future<CreatedPostDto> createPost({
    @Header(authentication) required String token,
    @Part(name: 'title') required String title,
    @Part(name: 'url') required String url,
    @Part(name: 'description') required String description,
    @Part(name: 'image') required List<MultipartFile> images,
  });

  @GET('post')
  Future<List<PostDto>> getPosts(
      {@Header(authentication) required String token});

  @GET('post/{id}')
  Future<PostDto> getPostById({
    @Header(authentication) required String token,
    @Path('id') required String id,
  });

  @DELETE('post/{id}')
  Future<CreatedPostDto> deletePost({
    @Header(authentication) required String token,
    @Path('id') required String id,
  });

  @PUT('post/{id}')
  Future<CreatedPostDto> updatePost({
    @Header(authentication) required String token,
    @Path('id') required String id,
    @Body() required CreatedPostPayloadDto payload,
  });
}
