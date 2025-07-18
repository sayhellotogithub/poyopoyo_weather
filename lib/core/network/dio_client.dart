// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'package:dio/dio.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.openweathermap.org/data/2.5/',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {'Accept': 'application/json'},
      ),
    );

    // Add interceptors for logging requests and responses
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: false,
        responseHeader: false,
        responseBody: true,
      ),
    );
  }
}
