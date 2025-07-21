// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/19
// Description: 
// -------------------------------------------------------------------
import '../../core/network/api_response.dart';
import '../entities/city.dart';

abstract class CityRepository {
  Future<ApiResponse<List<City>>> searchCities(String keyword);
}