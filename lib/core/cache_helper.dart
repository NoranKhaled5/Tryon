import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    if (sharedPreferences == null) return false;
    return await sharedPreferences!.setBool(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    if (sharedPreferences == null) return null;
    return sharedPreferences!.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (sharedPreferences == null) return false;

    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is double) return await sharedPreferences!.setDouble(key, value);

    return false;
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    if (sharedPreferences == null) return false;
    return await sharedPreferences!.remove(key);
  }

  static bool? getBoolean({
    required String key,
  }) {
    return sharedPreferences?.getBool(key);
  }
}
