import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  final SharedPreferences _prefs;

  AppStorage(this._prefs);

  static const String keyIsDarkMode = 'is_dark_mode';
  static const String keySelectedRole = 'selected_role';
  static const String keyOnboardingCompleted = 'onboarding_completed';

  Future<bool> setDarkMode(bool value) async {
    return await _prefs.setBool(keyIsDarkMode, value);
  }

  bool get isDarkMode => _prefs.getBool(keyIsDarkMode) ?? false;

  Future<bool> setSelectedRole(String role) async {
    return await _prefs.setString(keySelectedRole, role);
  }

  String get selectedRole => _prefs.getString(keySelectedRole) ?? 'mahasiswa';

  Future<bool> setOnboardingCompleted(bool value) async {
    return await _prefs.setBool(keyOnboardingCompleted, value);
  }

  bool get isOnboardingCompleted => _prefs.getBool(keyOnboardingCompleted) ?? false;

  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}
