import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

@module
abstract class CoreModule {
  Dio dio() {
    final baseOptions = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      validateStatus: (status) {
        return status != null && status < 500;
      },
    );

    // Only add sendTimeout if not on web platform
    if (!kIsWeb) {
      baseOptions.sendTimeout = const Duration(seconds: 30);
    }

    final dio = Dio(baseOptions)
      ..interceptors.add(AwesomeDioInterceptor(
        logRequestTimeout: true,
        logRequestHeaders: true,
        logResponseHeaders: true,
      ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          if (error.response?.statusCode == 401 &&
              error.response?.data['message'] == 'Unauthorised') {
            // _handleTokenExpiration();
          }
          return handler.next(error);
        },
      ),
    );

    return dio;
  }


  Future<SharedPreferences> preferences() async {
    return await SharedPreferences.getInstance();
  }
}
