// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description:
// -------------------------------------------------------------------
import '../../domain/entities/city.dart';

class CityDto {
  final String name;
  final String country;
  final double lat;
  final double lon;
  final String? state;
  final Map<String, String>? localNames;

  CityDto({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
    this.state,
    this.localNames,
  });

  factory CityDto.fromJson(Map<String, dynamic> json) {
    return CityDto(
      name: json['name'],
      country: json['country'],
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      state: json['state'],
      localNames: json['local_names'] != null
          ? Map<String, String>.from(json['local_names'] as Map)
          : null,
    );
  }

  City toEntity() => City(
    name: name,
    country: country,
    lat: lat,
    lon: lon,
    state: state,
    localNames: localNames,
  );
}
