import 'package:shared_preferences/shared_preferences.dart';


class StorageService {
final SharedPreferences _prefs;
StorageService(this._prefs);


Future<void> saveToken(String token) async => await _prefs.setString('token', token);
String? readToken() => _prefs.getString('token');
Future<void> clear() async => await _prefs.clear();

  // Save userId
  Future<void> saveUserId(int userId) async => await _prefs.setInt('user_id', userId);
  int? readUserId() => _prefs.getInt('user_id');
}