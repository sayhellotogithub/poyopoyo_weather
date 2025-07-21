// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poyopoyo_weather/core/network/api_response.dart';
import 'package:poyopoyo_weather/core/network/dio_client.dart';
import 'package:poyopoyo_weather/data/repositories/weather_repository_impl.dart';
import 'package:poyopoyo_weather/domain/entities/weather.dart';

void main() async {
  late String apiKey;

  setUpAll(() async {
    await dotenv.load(fileName: '.env');
    apiKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';
  });

  final cityName = 'Tokyo';

  test(
    'fetch current weather from OpenWeatherMap API (real network)',
    () async {
      final dio = DioClient(
        baseUrl: 'https://api.openweathermap.org/data/2.5/',
      ).dio;

      final repo = WeatherRepositoryImpl(dio: dio, apiKey: apiKey ?? "");
      final result = await repo.fetchCurrentWeather(
        cityName: cityName,
        lang: 'en',
      );

      expect(result, isA<ApiResponse<Weather>>());

      if (result is ApiSuccess<Weather>) {
        print('✅ Success: ${result.data.city}, ${result.data.temperature}°C');
        expect(result.data.city, cityName);
      } else if (result is ApiFailure<Weather>) {
        print('❌ Failure: ${result.messageKey}');
        fail('API returned failure: ${result.messageKey}');
      }
    },
  );
}
