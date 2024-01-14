import 'package:ecode_fess/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<SharedPreferences> get _instance async =>
      prefs ??= await SharedPreferences.getInstance();
  static SharedPreferences? prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    prefs = await _instance;
    return prefs ?? await SharedPreferences.getInstance();
  }

  static String? getToken() {
    return prefs?.getString(Constants.prefToken);
  }

  static Future<void> setToken(String token) async {
    await prefs?.setString(Constants.prefToken, token);
  }

  static int? getUserId() {
    return prefs?.getInt(Constants.prefUserId);
  }

  static Future<void> setUserId(int userId) async {
    await prefs?.setInt(Constants.prefUserId, userId);
  }

  static Future<void> clearAllPrefs() async {
    await prefs?.clear();
  }
}
