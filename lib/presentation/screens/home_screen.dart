// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poyopoyo_weather/l10n/app_localizations.dart';
import 'package:poyopoyo_weather/presentation/routes/app_router.dart';

import '../components/search/city_search_result_list.dart';
import '../components/search/search.dart';
import '../providers/city_providers.dart';
import '../providers/locale_provider.dart';
import '../providers/weather_list_providers.dart';
import '../utils/error_snackbar_listener.dart';
import '../widgets/weather_list_view_animated.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final local = AppLocalizations.of(context)!;
    final headViewModel = ref.watch(searchHeaderViewModelProvider);
    final citySearchViewModel = ref.watch(citySearchViewModelProvider.notifier);
    final weatherViewModel = ref.read(weatherListViewModelProvider.notifier);
    final weatherList = ref.watch(weatherListProvider);
    final locale = ref.watch(localeProvider);
    showErrorOnStateChange(
      ref: ref,
      context: context,
      provider: weatherListViewModelProvider,
    );

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: HeaderBarWithSearch(
                isSearching: headViewModel.isSearching,
                controller: headViewModel.controller,
                focusNode: headViewModel.focusNode,
                onTapSearch: () => headViewModel.startSearch(),
                onCancelSearch: () => headViewModel.cancelSearch(),
                onSettingsTap: () {
                  context.push(settingPath);
                },
                onChanged: (value) {
                  citySearchViewModel.search(value);
                },
              ),
            ),
            headViewModel.isSearching
                ? CitySearchResultList(
                    onCityTap: (city) async {
                      await weatherViewModel.addWeatherByCity(
                        city.name,
                        locale.languageCode,
                      );
                      headViewModel.cancelSearch();
                      citySearchViewModel.clearResults();
                    },
                  )
                : WeatherListViewAnimated(
                    isSearching: headViewModel.isSearching,
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
