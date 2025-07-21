// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:poyopoyo_weather/application/usecases/fetch_current_weather_usecase.dart';
import 'package:poyopoyo_weather/core/network/api_response.dart';
import 'package:poyopoyo_weather/domain/entities/weather.dart';

import '../../mocks/dummy_values.dart';
import '../../mocks/mocks.mocks.dart';

void main() {
  registerAllDummyValues();
  late MockWeatherRepository mockWeatherRepository;
  late FetchCurrentWeatherUseCase useCase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    useCase = FetchCurrentWeatherUseCase(mockWeatherRepository);
  });

  test('Fetch current weather success', () async {
    // Arrange
    final cityName = 'Tokyo';
    final weather = Weather(
      city: cityName,
      temperature: 27,
      maxTemp: 30,
      minTemp: 25,
      condition: '曇り',
      time: '09:00',
      icon: '01d',
    );
    when(
      mockWeatherRepository.fetchCurrentWeather(cityName: cityName, lang: 'ja'),
    ).thenAnswer((_) async => ApiResponse.success(weather));

    final result = await useCase.execute(cityName);

    expect(result, isA<ApiResponse<Weather>>());
    expect((result as ApiSuccess).data.city, cityName);
  });

  test('Fetch current weather failure', () async {
    const city = 'Osaka';

    when(
      mockWeatherRepository.fetchCurrentWeather(cityName: city, lang: 'ja'),
    ).thenAnswer((_) async => ApiResponse.failure('ネットワークエラー'));

    final result = await useCase.execute(city);

    expect(result, isA<ApiFailure<Weather>>());
    expect((result as ApiFailure).messageKey, 'ネットワークエラー');
  });
}
