// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/20
// Description:
// -------------------------------------------------------------------
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/presentation/providers/weather_providers.dart';

import '../../domain/entities/weather.dart';
import '../viewmodels/weather_list_view_model.dart';

final weatherListViewModelProvider =
    StateNotifierProvider<WeatherListViewModel, WeatherListState>((ref) {
      return WeatherListViewModel(
        currentWeatherUseCase: ref.watch(fetchCurrentWeatherUseCaseProvider),
        fetchWeatherByLocationUseCase: ref.watch(
          fetchCurrentWeatherByLocationUseCaseProvider,
        ),
      );
    });

final weatherListProvider = Provider<List<Weather>>((ref) {
  return ref.watch(weatherListViewModelProvider).weatherList;
});
