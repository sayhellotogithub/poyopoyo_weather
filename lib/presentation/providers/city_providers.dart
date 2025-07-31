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
import '../../data/network/city_api.dart';

final cityRepositoryProvider = Provider<CityRepository>((ref) {
  final client = ref.watch(weatherApiClientProvider);
  final cityApi = CityApi(client.dio, baseUrl: client.dio.options.baseUrl);
  return CityRepositoryImpl(api: cityApi, apiKey: client.apiKey);
});
final searchCityUseCaseProvider = Provider<SearchCityUseCase>((ref) {
  final repository = ref.read(cityRepositoryProvider);
  return SearchCityUseCase(repository);
});

final citySearchViewModelProvider =
    NotifierProvider<CitySearchViewModel, CitySearchState>(
      CitySearchViewModel.new,
    );
