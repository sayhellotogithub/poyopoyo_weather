// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient._internal(this._dio);

  factory DioClient({required String baseUrl}) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      contentType: 'application/json',
      responseType: ResponseType.json,
    );

    final dio = Dio(options);

    // Add interceptors for logging requests and responses
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
      ),
    );
    return DioClient._internal(dio);
  }

  Dio get dio => _dio;
}
