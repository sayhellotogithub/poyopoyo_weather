// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description: 
// -------------------------------------------------------------------
import 'package:flutter/material.dart';

import '../../domain/entities/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(
          weather.city,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${weather.condition} ・${weather.time}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${weather.temperature.toStringAsFixed(0)}°C',
                style: const TextStyle(fontSize: 24)),
            Text('↑${weather.maxTemp.toInt()} ↓${weather.minTemp.toInt()}',
                style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
