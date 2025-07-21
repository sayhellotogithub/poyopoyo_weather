// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poyopoyo_weather/l10n/app_localizations.dart';
import 'package:poyopoyo_weather/presentation/components/search/header_bar_with_search.dart';
import 'package:poyopoyo_weather/presentation/routes/app_router.dart';

import '../../domain/entities/city.dart';
import '../components/search/search.dart';
import '../providers/city_providers.dart';
import '../providers/locale_provider.dart';
import '../providers/weather_list_providers.dart';
import '../widgets/weather_list_view_animated.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final local = AppLocalizations.of(context)!;
    final viewModel = ref.watch(searchHeaderViewModelProvider);
    final citySearchViewModel = ref.read(citySearchViewModelProvider.notifier);
    final weatherViewModel = ref.read(weatherListViewModelProvider.notifier);
    final weatherList = ref.watch(weatherListProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: HeaderBarWithSearch(
                isSearching: viewModel.isSearching,
                controller: viewModel.controller,
                focusNode: viewModel.focusNode,
                onTapSearch: () => viewModel.startSearch(),
                onCancelSearch: () => viewModel.cancelSearch(),
                onSettingsTap: () {
                  context.push(settingPath);
                },
                onChanged: (value) {
                  citySearchViewModel.search(value);
                },
              ),
            ),
            viewModel.isSearching && !viewModel.isEmpty
                ? CitySearchResultList(
                    onCityTap: (city) async {
                      await weatherViewModel.addWeatherByLocation(
                        city.lat,
                        city.lon,
                        locale.languageCode,
                      );
                      viewModel.cancelSearch();
                      citySearchViewModel.clearResults();
                    },
                  )
                : WeatherListViewAnimated(
                    isSearching: viewModel.isSearching,
                    weatherList: weatherList,
                    onItemTap: (item) {
                      context.push(weatherDetailPath, extra: item.city);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class CitySearchResultList extends ConsumerWidget {
  final void Function(City) onCityTap;

  const CitySearchResultList({super.key, required this.onCityTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(citySearchViewModelProvider);

    if (state.isLoading) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (state.error != null) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              '⚠️ エラー: ${state.error}',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
    }

    if (state.results.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text('都市が見つかりませんでした'),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final city = state.results[index];
        final locale = Localizations.localeOf(context);
        final displayName = city.localNames?[locale.languageCode] ?? city.name;
        final subtitle = '${city.state ?? ''}, ${city.country}';

        return ListTile(
          title: Text(displayName),
          subtitle: Text(subtitle),
          onTap: () => onCityTap(city),
        );
      }, childCount: state.results.length),
    );
  }
}
