import 'package:shared_preferences/shared_preferences.dart';

class MoviesSharedPrefs {
  final SharedPreferences _preferences;

  MoviesSharedPrefs(this._preferences);

  /// __________ Clear Storage __________ ///
  Future<bool> clearAllLocalData() async {
    return true;
  }
}
