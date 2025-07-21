// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/21
// Description:
// -------------------------------------------------------------------
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String iconCode;
  final double size;

  const WeatherIcon({super.key, required this.iconCode, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://openweathermap.org/img/wn/${iconCode}@2x.png',
      width: size,
      height: size,
      placeholder: (_, __) => const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      errorWidget: (_, __, ___) => const Icon(Icons.error),
    );
  }
}
