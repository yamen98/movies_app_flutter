import 'package:movies_app/src/core/util/constant/local_storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs {
  final SharedPreferences _preferences;

  AppSharedPrefs(this._preferences);

  /// __________ Language __________ ///
  String? getLang() {
    return _preferences.getString(lang);
  }

  void setLang(String local) {
    _preferences.setString(lang, local);
  }

  /// __________ Dark Theme __________ ///
  bool getIsDarkTheme() {
    return _preferences.getBool(theme) ?? true;
  }

  void setDarkTheme(bool isDark) {
    _preferences.setBool(theme, isDark);
  }
}
