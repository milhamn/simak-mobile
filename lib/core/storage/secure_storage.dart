import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage(this._storage);

  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserData = 'user_data';

  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await _storage.write(key: keyAccessToken, value: accessToken);
    await _storage.write(key: keyRefreshToken, value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: keyAccessToken);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: keyRefreshToken);
  }

  Future<void> saveUserData(String jsonString) async {
    await _storage.write(key: keyUserData, value: jsonString);
  }

  Future<String?> getUserData() async {
    return await _storage.read(key: keyUserData);
  }

  Future<void> clearSession() async {
    await _storage.delete(key: keyAccessToken);
    await _storage.delete(key: keyRefreshToken);
    await _storage.delete(key: keyUserData);
  }
}
