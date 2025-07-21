// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'package:go_router/go_router.dart';
import 'package:poyopoyo_weather/presentation/screens/city_weather_detail_screen.dart';
import 'package:poyopoyo_weather/presentation/screens/home_screen.dart';
import 'package:poyopoyo_weather/presentation/screens/settings_screen.dart';
import 'package:poyopoyo_weather/presentation/utils/go_router_helpers.dart';

final homePath = "/home";
final settingPath = "/setting";
final weatherDetailPath = "/weatherDetail";

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRouteX.custom(path: settingPath, builder: (_, __) => SettingsScreen()),
    GoRouteX.custom(
      path: weatherDetailPath,
      builder: (_, state) {
        final cityName = state.extra as String;
        return CityWeatherDetailScreen(cityName: cityName);
      },
    ),
    // Placeholder for search city screen
  ],
);
