import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static late SharedPreferences _preferences;

  static const _keyTheme = "isDarkTheme";
  static const _keyFirstTime = "isFirstTime";

  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }


  static Future setTheme(bool flag) async {
    return _preferences.setBool(_keyTheme, flag);
  }

  static bool getTheme() {
    return _preferences.getBool(_keyTheme) ?? false;
  }


  static Future setFirstTime(bool flag) async {
    return _preferences.setBool(_keyFirstTime, flag);
  }

  static bool getFirstTime() {
    return _preferences.getBool(_keyFirstTime) ?? true;
  }
}