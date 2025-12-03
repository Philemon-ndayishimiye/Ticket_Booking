import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;
  StorageService(this._prefs);

  // Save token
  Future<void> saveToken(String token) async => await _prefs.setString('token', token);

  // Read token
  String? readToken() => _prefs.getString('token');

  // Clear all data
  Future<void> clear() async => await _prefs.clear();

  // Save userId
  Future<void> saveUserId(int userId) async => await _prefs.setInt('user_id', userId);
  
    // Save refresh token
  Future<void> saveRefreshToken(String refreshToken) async =>
      await _prefs.setString('refresh_token', refreshToken);

  // Read refresh token
  String? readRefreshToken() => _prefs.getString('refresh_token');

  // Clear refresh token
  Future<void> clearRefreshToken() async => await _prefs.remove('refresh_token');
  // Read userId
  int? readUserId() => _prefs.getInt('user_id');

  // Clear only token
  Future<void> clearToken() async => await _prefs.remove('token');

  // Clear only userId
  Future<void> clearUserId() async => await _prefs.remove('user_id');
}
