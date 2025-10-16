import 'dart:async';
import 'dart:io';

import 'package:curated_app/core/di/core_module_container.dart';
import 'package:curated_app/core/domain/utils/utils.dart';
import 'package:curated_app/core/presentation/utils/custom_state.dart';
import 'package:curated_app/core/presentation/utils/navigation_mixin.dart';
import 'package:curated_app/features/auth/presentation/screens/login.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Success<T> extends ApiResult<T> {
  final T result;

  Success(this.result) : super(result, null);
}

class Failure<T> extends ApiResult<T> {
  Failure(dynamic error, [T? data]) : super(data, error);
}

sealed class ApiResult<T> {
  final T? data;
  final dynamic error;

  ApiResult([this.data, this.error]);

  factory ApiResult.success(T data) => Success<T>(data);

  factory ApiResult.failure(dynamic error, [T? data]) =>
      Failure<T>(error, data);

  T? getOrElse([T? Function(Object)? defaultValue]) {
    switch (this) {
      case Success<T>():
        return data!;
      case Failure<T>():
        final error = toError();
        if (error.contains('Unauthorised') ||
            error.contains('Uauthorised') ||
            error.contains('Invalid Auth')) {
          navigator.currentContext?.pushNamedAndClear(
            LoginPage.id,
            args: "Your session has expired. Re-Login to continue.",
          );
          final sp = getIt.getAsync<SharedPreferences>();
          sp.then((value) {
            value.remove(user);
          });
        } else {
          return defaultValue?.call(toError());
        }
        return defaultValue?.call(error);
    }
  }

  String toError() {
    final e = error;
    switch (e) {
      case Map<String, dynamic> _:
        final error = e['message'] ?? e['error'];
        if (error != null) return error.toString();
      case DioException _:
        try {
          if (e.response?.data != null && e.response?.data != '') {
            Logger().d('ERROR: -> ${e.response!.data['error']}');
            if (e.response!.data['message'] != null) {
              return e.response!.data['message'].toString();
            }

            final error = e.response!.data['error'];
            if (error != null && error is String) {
              return error;
            }
          }

          if (e.type == DioExceptionType.connectionError) {
            return 'Connection could not be established. Check your internet connection ';
          }
        } catch (e) {
          return 'Oops! Service is temporarily unavailable';
        }
        break;
      case TimeoutException _:
        return 'Request time out';
      case SocketException _:
        return 'Connection could not be established. Check internet';

      case FormatException _:
        return e.message;

      //case Error:
      case String _:
        return e;
    }
    return 'Oops! an error occurred an request could not be completed';
  }
}
