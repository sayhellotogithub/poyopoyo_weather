// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description: 
// -------------------------------------------------------------------
abstract class ThemeRepository {
  Future<int> getThemeMode();
  Future<void> saveThemeMode(int mode);
}