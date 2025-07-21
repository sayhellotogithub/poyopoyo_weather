// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityDto _$CityDtoFromJson(Map<String, dynamic> json) => CityDto(
  name: json['name'] as String,
  country: json['country'] as String,
  lat: (json['lat'] as num).toDouble(),
  lon: (json['lon'] as num).toDouble(),
  state: json['state'] as String?,
  localNames: (json['local_names'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
);

Map<String, dynamic> _$CityDtoToJson(CityDto instance) => <String, dynamic>{
  'name': instance.name,
  'country': instance.country,
  'lat': instance.lat,
  'lon': instance.lon,
  'state': instance.state,
  'local_names': instance.localNames,
};
