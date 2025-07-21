// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/data/repositories/city_repository_impl.dart';
import 'package:poyopoyo_weather/domain/repositories/city_repository.dart';
import 'package:poyopoyo_weather/presentation/providers/weather_api_providers.dart';
import 'package:poyopoyo_weather/presentation/viewmodels/city_search_view_model.dart';

import '../../application/usecases/search_city_usecase.dart';

final cityRepositoryProvider = Provider<CityRepository>((ref) {
  final client = ref.read(weatherApiClientProvider);
  return CityRepositoryImpl(dio: client.dio, apiKey: client.apiKey);
});
final searchCityUseCaseProvider = Provider<SearchCityUseCase>((ref) {
  final repository = ref.read(cityRepositoryProvider);
  return SearchCityUseCase(repository);
});

final citySearchViewModelProvider =
    StateNotifierProvider<CitySearchViewModel, CitySearchState>(
      (ref) => CitySearchViewModel(
        searchCityUseCase: ref.read(searchCityUseCaseProvider),
      ),
    );
