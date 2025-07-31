// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/20
// Description:
// -------------------------------------------------------------------
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/weather.dart';
import '../viewmodels/weather_list_view_model.dart';

final weatherListViewModelProvider =
    NotifierProvider<WeatherListViewModel, WeatherListState>(
      WeatherListViewModel.new,
    );

final weatherListProvider = Provider<List<Weather>>((ref) {
  return ref.watch(weatherListViewModelProvider).weatherList;
});
