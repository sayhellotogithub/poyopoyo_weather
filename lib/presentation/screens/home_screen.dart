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
import 'package:poyopoyo_weather/presentation/providers/weather_providers.dart';
import 'package:poyopoyo_weather/presentation/routes/app_router.dart';

import '../components/search/search.dart';
import '../widgets/weather_list_view_animated.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final local = AppLocalizations.of(context)!;
    final weatherList = ref.watch(weatherListProvider);
    final viewModel = ref.watch(searchHeaderViewModelProvider);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header 搜索栏
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
              ),
            ),
            // 城市列表
            WeatherListViewAnimated(
              isSearching: viewModel.isSearching,
              weatherList: weatherList,
              onItemTap: (item) {
                context.push(weatherDetailPath, extra: item);
              },
            ),
          ],
        ),
      ),
    );
  }
}
