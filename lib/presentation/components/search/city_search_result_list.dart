// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/21
// Description:
// -------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/domain/entities/city.dart';
import 'package:poyopoyo_weather/presentation/components/search/search_header_view_model.dart';

import '../../../l10n/app_localizations.dart';
import '../../providers/city_providers.dart';

class CitySearchResultList extends ConsumerWidget {
  final void Function(City) onCityTap;

  const CitySearchResultList({super.key, required this.onCityTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(citySearchViewModelProvider);
    final loc = AppLocalizations.of(context)!;

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
              '⚠️  ${state.error}',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
    }

    if (state.results.isEmpty) {
      final header = ref.watch(searchHeaderViewModelProvider);
      if (header.controller.text.trim().isEmpty) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(loc.cityNotFound),
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
