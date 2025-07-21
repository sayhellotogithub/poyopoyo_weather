// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:poyopoyo_weather/domain/entities/weather.dart';
import 'package:poyopoyo_weather/presentation/widgets/weather_card.dart';

class WeatherListViewAnimated extends StatelessWidget {
  final List<Weather> weatherList;
  final bool isSearching;
  final void Function(Weather) onItemTap;

  const WeatherListViewAnimated({
    super.key,
    required this.weatherList,
    required this.isSearching,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final weather = weatherList[index];
          return InkWell(
            onTap: () => onItemTap(weather),
            child: WeatherCard(weather: weather),
          );
        }, childCount: weatherList.length),
      ),
    );
  }
}
