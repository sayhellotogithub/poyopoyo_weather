// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:poyopoyo_weather/domain/entities/weather.dart';

class CityWeatherDetailScreen extends StatelessWidget {
  final Weather weather;

  const CityWeatherDetailScreen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final hourlyTemps = [29, 28, 27, 27, 26, 25]; // mock数据
    final dailyForecast = [
      {'day': '今日', 'max': 32, 'min': 25},
      {'day': '土', 'max': 32, 'min': 24},
      {'day': '日', 'max': 33, 'min': 25},
      {'day': '月', 'max': 34, 'min': 26},
    ]; // 可从API动态生成

    return Scaffold(
      appBar: AppBar(title: Text(weather.city)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 当前天气显示
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  '${weather.temperature.toInt()}°C',
                  style: const TextStyle(fontSize: 60),
                ),
                Text(
                  '${weather.condition}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  '最高 ${weather.maxTemp.toInt()}° 最低 ${weather.minTemp.toInt()}°',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          // 天气描述
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '20:00頃にところにより曇りの予想です。最大風速は12m/sです。',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),

          // 時間帯ごとの天気（横スクロール）
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hourlyTemps.length,
              itemBuilder: (context, index) {
                final hour = 18 + index;
                return Container(
                  width: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$hour時'),
                      const Icon(Icons.cloud, size: 24),
                      Text('${hourlyTemps[index]}°'),
                    ],
                  ),
                );
              },
            ),
          ),

          const Divider(),

          // 10日間天気予報
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '10日間天気予報',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...dailyForecast.map((day) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        SizedBox(width: 50, child: Text(day['day'].toString())),
                        const Icon(Icons.cloud, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.5,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.orange,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('${day['min']}° / ${day['max']}°'),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
