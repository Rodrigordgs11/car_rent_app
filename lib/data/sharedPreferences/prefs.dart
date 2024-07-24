import 'package:shared_preferences/shared_preferences.dart';

class Prefs{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> setSharedPref(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(key, value);
  }

  Future<String?> getSharedPref(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  Future<bool> removeSharedPref(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(key);
  }

  Future<bool> clearSharedPref() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.clear();
  }
}