import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiResult<T>{
  final T? data;
  final dynamic error;

  ApiResult([this.data, this.error]);

  factory ApiResult.success(T data) => ApiResult(data);

  factory ApiResult.failure(dynamic error, [T? data]) => ApiResult(data, error);

  T? getOrElse([T? Function(Object)? defaultValue]) {
    if (data == null) {
      return defaultValue == null ? null : defaultValue(toError());
    }else{
      return data!;
    }
  }

String toError() {
  final e = error!;
  if (e is DioException) {
    try {

      // Check for 500-series errors first
      if (e.response?.statusCode != null && 
          e.response!.statusCode! >= 500 && 
          e.response!.statusCode! < 600) {
        Logger().e('Server Error: ${e.response?.statusCode}');
        return 'Oops! An error occurred and request could not be completed';
      }

      final responseData = e.response?.data;
      if (responseData != null && responseData is Map<String, dynamic>) {
        // Prioritize 'message' field
        if (responseData.containsKey('message')) {
          final message = responseData['message'].toString();
          Logger().e('MESSAGE: -> $message');
          return message;
        }
        // Fallback to 'error' field if 'message' is not present
        if (responseData.containsKey('error')) {
          final errorMessage = responseData['error'].toString();
          Logger().e('ERROR: -> $errorMessage');
          return errorMessage;
        }
      }
      
      // If no specific message found in response data, return Dio error message
      return e.message ?? 'An unexpected error occurred';
    } catch (parseError) {
      Logger().e('Error parsing DioException: $parseError');
      return 'An error occurred while processing your request';
    }
  } else if (e is TimeoutException) {
    return 'Request timed out';
  } else if (e is SocketException) {
    return 'Connection could not be established. Check internet';
  } else if (e is FormatException) {
    return e.message;
  } else if (e is String) {
    return e;
  }
  return 'Oops! An error occurred and request could not be completed';
}
}