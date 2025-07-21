// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description: Adaptive and Maintainable City Weather Detail Screen
// -------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../domain/entities/forecast_weather.dart';
import '../providers/locale_provider.dart';
import '../providers/weather_providers.dart';
import '../utils/date_time_utils.dart';
import '../widgets/hourly_temp_chart.dart';
import '../widgets/weather_icon.dart';

class CityWeatherDetailScreen extends ConsumerStatefulWidget {
  final String cityName;

  const CityWeatherDetailScreen({super.key, required this.cityName});

  @override
  ConsumerState<CityWeatherDetailScreen> createState() =>
      _CityWeatherDetailScreenState();
}

class _CityWeatherDetailScreenState
    extends ConsumerState<CityWeatherDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(weatherViewModelProvider.notifier)
          .loadWeather(widget.cityName, ref.read(localeProvider).languageCode),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(weatherViewModelProvider);
    final weather = state.current;
    final forecastList = state.forecast;
    final locale = ref.watch(localeProvider);

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.errorMessage != null) {
      return Scaffold(body: Center(child: Text(state.errorMessage!)));
    }

    if (weather == null || forecastList == null || forecastList.isEmpty) {
      return const Scaffold(body: Center(child: Text('データが見つかりませんでした')));
    }

    final hourly = forecastList.take(8).toList();
    final dailyForecast = _groupForecastByDay(forecastList);

    return Scaffold(
      appBar: AppBar(title: Text(weather.city)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth < 360;
            final iconSize = isSmall ? 40.0 : 50.0;
            final fontSize = isSmall ? 12.0 : 14.0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCurrentWeather(weather, fontSize),
                const SizedBox(height: 16),
                const Divider(),
                _buildHourlyForecast(
                  hourly,
                  iconSize,
                  fontSize,
                  locale.languageCode,
                ),
                const Divider(),
                _buildDailyForecast(
                  dailyForecast,
                  fontSize,
                  locale.languageCode,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCurrentWeather(dynamic weather, double fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${weather.temperature.toInt()}°C',
          style: const TextStyle(fontSize: 48),
        ),
        Row(
          children: [
            Text(weather.condition, style: TextStyle(fontSize: fontSize + 4)),
            WeatherIcon(iconCode: weather.icon, size: 40),
          ],
        ),
        Text(
          '最高 ${weather.maxTemp.toInt()}° 最低 ${weather.minTemp.toInt()}°',
          style: TextStyle(fontSize: fontSize),
        ),
      ],
    );
  }

  Widget _buildHourlyForecast(
    List<ForecastWeather> hourly,
    double iconSize,
    double fontSize,
    String locale,
  ) {
    return SizedBox(
      height: iconSize + fontSize * 2 + 24,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: hourly.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          final h = hourly[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateTimeUtils.formatLocalizedHour(h.dateTime, locale: locale),
                style: TextStyle(fontSize: fontSize),
              ),
              const SizedBox(height: 4),
              WeatherIcon(iconCode: h.icon, size: iconSize),
              const SizedBox(height: 4),
              Text(
                '${h.temperature.toInt()}°',
                style: TextStyle(fontSize: fontSize),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDailyForecast(
    List<Map<String, dynamic>> dailyForecast,
    double fontSize,
    String locale,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '5日間予報',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize + 2),
        ),
        const SizedBox(height: 8),
        ...dailyForecast.map(
          (day) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Text(day['day'], style: TextStyle(fontSize: fontSize)),
                const SizedBox(width: 10),
                const Icon(Icons.cloud, size: 20),
                const SizedBox(width: 20),
                Expanded(
                  child: HourlyTempChart(
                    hourly: List<ForecastWeather>.from(day['hourly']),
                    locale: locale,
                    height: 50, // 可选高度压缩一点
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _groupForecastByDay(List<ForecastWeather> list) {
    final map = <String, List<ForecastWeather>>{};
    list.sort((a, b) => a.dateTime.compareTo(b.dateTime)); // 保证顺序
    for (var item in list) {
      Logger().d('📅 ${item.dateTime} 🌡️ ${item.temperature}°C');
    }
    for (var item in list) {
      final day = DateTimeUtils.extractDate(item.dateTime);
      map.putIfAbsent(day, () => []).add(item);
    }
    final today = DateTimeUtils.extractDate(DateTime.now().toIso8601String());

    return map.entries
        .where((entry) => entry.key != today) // 🚫 除外今天
        .map((entry) {
          final day = entry.key;
          final values = entry.value;
          return {
            'day': day.substring(5), // "MM-DD"
            'hourly': values,
            'max': values
                .map((e) => e.temperature)
                .reduce((a, b) => a > b ? a : b)
                .toInt(),
            'min': values
                .map((e) => e.temperature)
                .reduce((a, b) => a < b ? a : b)
                .toInt(),
          };
        })
        .toList();
  }
}
