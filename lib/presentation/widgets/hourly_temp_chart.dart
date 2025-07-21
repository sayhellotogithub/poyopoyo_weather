// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/21
// Description:
// -------------------------------------------------------------------
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:poyopoyo_weather/presentation/utils/date_time_utils.dart';

import '../../domain/entities/forecast_weather.dart';

class HourlyTempChart extends StatelessWidget {
  final List<ForecastWeather> hourly;
  final String locale;
  final double height;

  const HourlyTempChart({
    super.key,
    required this.hourly,
    required this.locale,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    if (hourly.isEmpty) {
      return const Center(child: Text('No data'));
    }

    final data = hourly.take(8).toList();

    final spots = data.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final temp = entry.value.temperature.toDouble();
      return FlSpot(index, temp);
    }).toList();

    final minTemp = data
        .map((e) => e.temperature)
        .reduce((a, b) => a < b ? a : b);
    final maxTemp = data
        .map((e) => e.temperature)
        .reduce((a, b) => a > b ? a : b);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= data.length)
                    return const SizedBox();
                  final hour = DateTimeUtils.formatLocalizedHour(
                    data[index].dateTime,
                  );
                  return Text(
                    '$hour',
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          minY: minTemp.floorToDouble() - 1,
          maxY: maxTemp.ceilToDouble() + 1,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.orange,
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(255, 165, 0, 0.3),
                    Color.fromRGBO(255, 165, 0, 0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
