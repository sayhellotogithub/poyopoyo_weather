// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
class ForecastWeather {
  final String dateTime;
  final double temperature;
  final String condition;
  final String icon;

  ForecastWeather({
    required this.dateTime,
    required this.temperature,
    required this.condition,
    required this.icon,
  });

  @override
  String toString() {
    return 'ForecastWeather(dateTime: $dateTime, temperature: $temperature, condition: $condition, icon: $icon)';
  }
}
