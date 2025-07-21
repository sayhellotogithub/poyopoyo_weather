// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:dio/dio.dart';

import 'api_response.dart';

Future<ApiResponse<T>> safeRequest<T>(Future<T> Function() request) async {
  try {
    final data = await request();
    return ApiResponse.success(data);
  } on DioException catch (e) {
    final messageKey = _mapErrorToKey(e);
    return ApiResponse.failure(messageKey);
  } catch (e) {
    return ApiResponse.failure(e.toString());
  }
}

String _mapErrorToKey(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return ErrorKeys.timeout;

    case DioExceptionType.badResponse:
      final status = e.response?.statusCode;
      if (status == 404) return ErrorKeys.notFound;
      if (status == 500) return ErrorKeys.server;
      return ErrorKeys.server;

    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
    default:
      return ErrorKeys.unknown;
  }
}

class ErrorKeys {
  static const timeout = 'error.timeout';
  static const server = 'error.server';
  static const notFound = 'error.notFound';
  static const unknown = 'error.unknown';
}
