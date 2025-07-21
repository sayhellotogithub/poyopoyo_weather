// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/application/usecases/fetch_current_weather_usecase.dart';
import 'package:poyopoyo_weather/application/usecases/fetch_forecaset_by_location_usecase.dart';
import 'package:poyopoyo_weather/application/usecases/fetch_forecast_usecase.dart';
import 'package:poyopoyo_weather/data/repositories/weather_repository_impl.dart';
import 'package:poyopoyo_weather/presentation/providers/weather_api_providers.dart';

import '../../application/usecases/fetch_weather_by_location_usecase.dart';
import '../state/weather_state.dart';
import '../viewmodels/weather_view_model.dart';

final weatherRepositoryProvider = Provider((ref) {
  final client = ref.read(weatherApiClientProvider);
  return WeatherRepositoryImpl(dio: client.dio, apiKey: client.apiKey);
});

final fetchCurrentWeatherUseCaseProvider = Provider((ref) {
  final repo = ref.watch(weatherRepositoryProvider);
  return FetchCurrentWeatherUseCase(repo);
});
final fetchCurrentWeatherByLocationUseCaseProvider = Provider((ref) {
  final repo = ref.watch(weatherRepositoryProvider);
  return FetchWeatherByLocationUseCase(repo);
});
final fetchForecastUseCaseProvider = Provider((ref) {
  final repo = ref.watch(weatherRepositoryProvider);
  return FetchForecastUseCase(repo);
});

final fetchForecastByLocationUseCaseProvider = Provider((ref) {
  final repo = ref.watch(weatherRepositoryProvider);
  return FetchForecastByLocationUseCase(repo);
});

final weatherViewModelProvider =
    StateNotifierProvider<WeatherViewModel, WeatherState>((ref) {
      final currentUseCase = ref.watch(fetchCurrentWeatherUseCaseProvider);
      final forecastUseCase = ref.watch(fetchForecastUseCaseProvider);
      return WeatherViewModel(
        fetchCurrentWeather: currentUseCase,
        fetchForecast: forecastUseCase,
      );
    });
