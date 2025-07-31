// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/application/usecases/search_city_usecase.dart';
import 'package:poyopoyo_weather/core/network/api_response.dart';
import 'package:poyopoyo_weather/domain/entities/city.dart';

import '../providers/city_providers.dart';

class CitySearchState {
  final bool isLoading;
  final List<City> results;
  final String? error;

  CitySearchState({
    this.isLoading = false,
    this.results = const [],
    this.error,
  });

  CitySearchState copyWith({
    bool? isLoading,
    List<City>? results,
    String? error,
  }) {
    return CitySearchState(
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
      error: error,
    );
  }
}

class CitySearchViewModel extends Notifier<CitySearchState> {
  late final SearchCityUseCase _searchCityUseCase;

  @override
  CitySearchState build() {
    _searchCityUseCase = ref.read(searchCityUseCaseProvider);
    return CitySearchState();
  }

  void clearResults() {
    state = state.copyWith(results: [], error: null);
  }

  Future<void> search(String keyword) async {
    if (keyword.isEmpty) {
      state = state.copyWith(results: [], error: null, isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: true);
    final res = await _searchCityUseCase.execute(keyword);
    if (res is ApiSuccess) {
      state = state.copyWith(
        results: (res as ApiSuccess).data,
        isLoading: false,
        error: null,
      );
    } else if (res is ApiFailure) {
      state = state.copyWith(
        error: (res as ApiFailure).messageKey,
        isLoading: false,
      );
    }
  }
}
