// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/core/network/weather_api_client.dart';

import '../../core/network/dio_client.dart';

final weatherApiClientProvider = Provider<WeatherApiClient>((ref) {
  final apiKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';
  final dio = DioClient(baseUrl: 'https://api.openweathermap.org/').dio;
  return WeatherApiClient(dio: dio, apiKey: apiKey);
});
