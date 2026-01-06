import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffe_app_ui/domain/entities/user_prefs.dart';

abstract class UserPrefsStorage {
  Future<UserPrefs> load();
  Future<void> save(UserPrefs prefs);
}

class SharedPrefsUserPrefsStorage implements UserPrefsStorage {
  static const _darkMode = 'prefs_dark_mode_v1';
  static const _reduceMotion = 'prefs_reduce_motion_v1';
  static const _favCategory = 'prefs_fav_category_v1';

  @override
  Future<UserPrefs> load() async {
    final prefs = await SharedPreferences.getInstance();
    final dark = prefs.getBool(_darkMode) ?? false;
    final reduce = prefs.getBool(_reduceMotion) ?? false;
    final fav = prefs.getString(_favCategory) ?? 'all';
    return UserPrefs(darkMode: dark, reduceMotion: reduce, favoriteCategoryId: fav);
    }

  @override
  Future<void> save(UserPrefs p) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkMode, p.darkMode);
    await prefs.setBool(_reduceMotion, p.reduceMotion);
    await prefs.setString(_favCategory, p.favoriteCategoryId);
  }
}
