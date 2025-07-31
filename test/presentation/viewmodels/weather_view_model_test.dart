// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:poyopoyo_weather/core/network/api_response.dart';
import 'package:poyopoyo_weather/domain/entities/forecast_weather.dart';
import 'package:poyopoyo_weather/domain/entities/weather.dart';
import 'package:poyopoyo_weather/presentation/providers/weather_providers.dart';
import 'package:poyopoyo_weather/presentation/viewmodels/weather_view_model.dart';

import '../../mocks/dummy_values.dart';
import '../../mocks/mocks.mocks.dart';

void main() {
  registerAllDummyValues();

  late ProviderContainer container;
  late MockFetchCurrentWeatherUseCase mockCurrentWeatherUseCase;
  late MockFetchForecastUseCase mockForecastUseCase;
  late WeatherViewModel viewModel;

  const testCity = 'Tokyo';

  final dummyWeather = Weather(
    city: 'Tokyo',
    temperature: 25.5,
    maxTemp: 28.0,
    minTemp: 22.0,
    condition: '晴れ',
    time: '12:00',
    icon: '01d',
  );

  final dummyForecast = [
    ForecastWeather(
      dateTime: '2025-07-20 12:00',
      temperature: 26.0,
      condition: '晴れ',
      icon: '01d',
    ),
    ForecastWeather(
      dateTime: '2025-07-20 15:00',
      temperature: 27.0,
      condition: 'くもり',
      icon: '02d',
    ),
  ];

  setUp(() {
    mockCurrentWeatherUseCase = MockFetchCurrentWeatherUseCase();
    mockForecastUseCase = MockFetchForecastUseCase();

    container = ProviderContainer(overrides: [
      fetchCurrentWeatherUseCaseProvider.overrideWithValue(mockCurrentWeatherUseCase),
      fetchForecastUseCaseProvider.overrideWithValue(mockForecastUseCase),
    ]);

    viewModel = container.read(weatherViewModelProvider.notifier);
  });

  test('both successful', () async {
    when(
      mockCurrentWeatherUseCase.execute(testCity),
    ).thenAnswer((_) async => ApiSuccess(dummyWeather));
    when(
      mockForecastUseCase.execute(testCity),
    ).thenAnswer((_) async => ApiSuccess(dummyForecast));

    await viewModel.loadWeather(testCity,"ja");

    expect(viewModel.state.isLoading, false);
    expect(viewModel.state.current?.city, 'Tokyo');
    expect(viewModel.state.forecast?.length, 2);
    expect(viewModel.state.errorMessage, isNull);
  });

  test(' current success, forecast failure', () async {
    when(
      mockCurrentWeatherUseCase.execute(testCity),
    ).thenAnswer((_) async => ApiSuccess(dummyWeather));
    when(
      mockForecastUseCase.execute(testCity),
    ).thenAnswer((_) async => const ApiFailure('取得失敗'));

    await viewModel.loadWeather(testCity,"ja");

    expect(viewModel.state.isLoading, false);
    expect(viewModel.state.current, dummyWeather);
    expect(viewModel.state.forecast, isNull);
    expect(viewModel.state.errorMessage, '取得失敗');
  });

  test('current failure, forecast failure', () async {
    when(
      mockCurrentWeatherUseCase.execute(testCity),
    ).thenAnswer((_) async => const ApiFailure('ネットワークエラーA'));
    when(
      mockForecastUseCase.execute(testCity),
    ).thenAnswer((_) async => const ApiFailure('ネットワークエラーB'));

    await viewModel.loadWeather(testCity,"ja");

    expect(viewModel.state.isLoading, false);
    expect(viewModel.state.current, isNull);
    expect(viewModel.state.forecast, isNull);
    expect(viewModel.state.errorMessage, contains('ネットワークエラー'));
  });


  tearDown(() {
    container.dispose();
  });
}
