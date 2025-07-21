// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description: 
// -------------------------------------------------------------------
class City {
  final String name;
  final String country;
  final double lat;
  final double lon;
  final String? state;
  final Map<String, String>? localNames;

  City({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
    this.state,
    this.localNames,
  });
}
