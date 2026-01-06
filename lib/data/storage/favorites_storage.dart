import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoritesStorage {
  Future<Set<String>> loadFavorites();
  Future<void> saveFavorites(Set<String> ids);
}

class SharedPrefsFavoritesStorage implements FavoritesStorage {
  static const _key = 'favorites_ids_v1';

  @override
  Future<Set<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? const [];
    return list.toSet();
  }

  @override
  Future<void> saveFavorites(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, ids.toList());
  }
}
