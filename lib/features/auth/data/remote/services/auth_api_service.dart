import 'package:curated_app/features/auth/data/remote/dto/auth_dto.dart';
import 'package:curated_app/features/auth/data/remote/dto/login_payload_dto.dart';
import 'package:curated_app/features/auth/data/remote/dto/register_payload_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: 'https://api.curated.forum/api/v1/')
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  static const authentication = 'Authorization';

  @POST('login')
  Future<AuthDto> login({@Body() required LoginPayloadDto payload});

  @POST('register')
  Future<AuthDto> register({@Body() required RegisterPayloadDto payload});

  @POST('logout')
  Future<void> logout({@Header(authentication) required String token});

  // @POST('auth/forgot-password')
  // Future<GenericModelDto> forgotPassword(
  //     {@Body() required EmailPayloadDto payload});

  // @PATCH('auth/reset-password')
  // Future<GenericModelDto> resetPassword(
  //     {@Body() required EmailPayloadDto payload});

  // @PATCH('auth/change-password')
  // Future<GenericModelDto> changePassword({
  //   @Header(authentication) required String token,
  //   @Body() required EmailPayloadDto payload,
  // });
}
