// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'package:go_router/go_router.dart';
import 'package:poyopoyo_weather/domain/entities/weather.dart';
import 'package:poyopoyo_weather/presentation/screens/city_weather_detail_screen.dart';
import 'package:poyopoyo_weather/presentation/screens/home_screen.dart';
import 'package:poyopoyo_weather/presentation/screens/search_city_screen.dart';
import 'package:poyopoyo_weather/presentation/screens/settings_screen.dart';
import 'package:poyopoyo_weather/presentation/utils/go_router_helpers.dart';

final homePath = "/home";
final settingPath = "/setting";
final searchCityPath = "/searchCity";
final weatherDetailPath = "/weatherDetail";

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRouteX.custom(path: settingPath, builder: (_, __) => SettingsScreen()),
    GoRouteX.custom(
      path: searchCityPath,
      builder: (_, __) => SearchCityScreen(),
    ),
    GoRouteX.custom(
      path: weatherDetailPath,
      builder: (_, state) {
        final weather = state.extra as Weather;
        return CityWeatherDetailScreen(weather: weather);
      },
    ),
    // Placeholder for search city screen
  ],
);
