// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description: 
// -------------------------------------------------------------------
import 'package:dio/dio.dart';

class WeatherApiClient {
  final Dio dio;
  final String apiKey;

  WeatherApiClient({required this.dio, required this.apiKey});
}