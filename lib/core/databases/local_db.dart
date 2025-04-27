import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static Future<void> saveCaption(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getCaption(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
