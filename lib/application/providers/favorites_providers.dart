import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffe_app_ui/data/storage/favorites_storage.dart';

final favoritesStorageProvider = Provider<FavoritesStorage>((ref) => SharedPrefsFavoritesStorage());

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier(this._storage) : super({}) {
    _init();
  }
  final FavoritesStorage _storage;

  Future<void> _init() async {
    final loaded = await _storage.loadFavorites();
    state = loaded;
  }

  bool isFavorite(String id) => state.contains(id);

  Future<void> toggle(String id) async {
    final set = {...state};
    if (!set.add(id)) set.remove(id);
    state = set;
    await _storage.saveFavorites(state);
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  final storage = ref.watch(favoritesStorageProvider);
  return FavoritesNotifier(storage);
});

final isFavoriteProvider = Provider.family<bool, String>((ref, id) {
  final favs = ref.watch(favoritesProvider);
  return favs.contains(id);
});
