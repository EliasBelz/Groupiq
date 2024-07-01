import 'package:shared_preferences/shared_preferences.dart';
// Sampled from https://github.com/suragch/flutter_pocketbase_tutorial/blob/master/lib/local_storage/local_storage.dart
// TODO: switch to flutter_secure_storage and hive

class LocalStorage {
  static const _tokenKey = 'token';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    print('reading token: $token');
    return token;
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    print('writing token: $token');
    await prefs.setString(_tokenKey, token);
  }

  Future<void> deleteToken() async {
    print('deleting token');
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_tokenKey);
  }
}
