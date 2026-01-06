import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffe_app_ui/domain/entities/user_prefs.dart';
import 'package:coffe_app_ui/data/storage/user_prefs_storage.dart';

final userPrefsStorageProvider = Provider<UserPrefsStorage>((ref) => SharedPrefsUserPrefsStorage());

class UserPrefsNotifier extends StateNotifier<AsyncValue<UserPrefs>> {
  UserPrefsNotifier(this._storage) : super(const AsyncLoading()) {
    _init();
  }
  final UserPrefsStorage _storage;

  Future<void> _init() async {
    try {
      final prefs = await _storage.load();
      state = AsyncData(prefs);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateDarkMode(bool value) async => _update((p) => p.copyWith(darkMode: value));
  Future<void> updateReduceMotion(bool value) async => _update((p) => p.copyWith(reduceMotion: value));
  Future<void> updateFavoriteCategory(String id) async => _update((p) => p.copyWith(favoriteCategoryId: id));

  Future<void> _update(UserPrefs Function(UserPrefs) fn) async {
    final current = state.value ?? UserPrefs.defaults();
    final next = fn(current);
    state = AsyncData(next);
    await _storage.save(next);
  }
}

final userPrefsProvider = StateNotifierProvider<UserPrefsNotifier, AsyncValue<UserPrefs>>((ref) {
  final storage = ref.watch(userPrefsStorageProvider);
  return UserPrefsNotifier(storage);
});
