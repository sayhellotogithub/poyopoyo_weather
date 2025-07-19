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
    return ApiResponse.failure(e.response?.data?['message'] ?? 'ネットワークエラー');
  } catch (e) {
    return ApiResponse.failure(e.toString());
  }
}
