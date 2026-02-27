import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffe_app_ui/domain/entities/coffee_entity.dart';
import 'package:coffe_app_ui/domain/repositories/favorite_repository.dart';
import 'package:coffe_app_ui/data/repositories/favorite_repository_impl.dart';
import 'package:coffe_app_ui/provider/auth_provider.dart';

// Repository provider
final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return FavoriteRepositoryImpl();
});

// Favorites state
class FavoritesState {
  final List<CoffeeEntity> favoriteCoffees;
  final bool isLoading;
  final String? error;

  const FavoritesState({
    this.favoriteCoffees = const [],
    this.isLoading = false,
    this.error,
  });

  FavoritesState copyWith({
    List<CoffeeEntity>? favoriteCoffees,
    bool? isLoading,
    String? error,
  }) {
    return FavoritesState(
      favoriteCoffees: favoriteCoffees ?? this.favoriteCoffees,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FavoritesState &&
        other.favoriteCoffees == favoriteCoffees &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode => favoriteCoffees.hashCode ^ isLoading.hashCode ^ error.hashCode;
}

// Favorites notifier
class FavoritesNotifier extends StateNotifier<FavoritesState> {
  final FavoriteRepository _repository;

  FavoritesNotifier(this._repository) : super(const FavoritesState());

  /// Load user favorites
  Future<void> loadFavorites(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final favoriteCoffees = await _repository.getFavoriteCoffees(userId);
      state = state.copyWith(
        favoriteCoffees: favoriteCoffees,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load favorites: ${e.toString()}',
      );
    }
  }

  /// Toggle favorite status
  Future<bool> toggleFavorite(String userId, String coffeeId) async {
    try {
      final isNowFavorite = await _repository.toggleFavorite(userId, coffeeId);
      
      // Reload favorites to update UI
      await loadFavorites(userId);
      
      return isNowFavorite;
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to toggle favorite: ${e.toString()}',
      );
      return false;
    }
  }

  /// Check if coffee is favorite
  Future<bool> isFavorite(String userId, String coffeeId) async {
    try {
      return await _repository.isFavorite(userId, coffeeId);
    } catch (e) {
      return false;
    }
  }

  /// Remove from favorites
  Future<void> removeFromFavorites(String userId, String coffeeId) async {
    try {
      await _repository.removeFromFavorites(userId, coffeeId);
      await loadFavorites(userId);
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to remove from favorites: ${e.toString()}',
      );
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider for favorites notifier
final favoritesNotifierProvider = StateNotifierProvider<FavoritesNotifier, FavoritesState>((ref) {
  final repository = ref.watch(favoriteRepositoryProvider);
  return FavoritesNotifier(repository);
});

// Convenience providers
final favoritesProvider = Provider<List<CoffeeEntity>>((ref) {
  return ref.watch(favoritesNotifierProvider).favoriteCoffees;
});

final favoritesLoadingProvider = Provider<bool>((ref) {
  return ref.watch(favoritesNotifierProvider).isLoading;
});

final favoritesErrorProvider = Provider<String?>((ref) {
  return ref.watch(favoritesNotifierProvider).error;
});

// Provider to check if a specific coffee is favorite
final isFavoriteProvider = Provider.family<bool, String>((ref, coffeeId) {
  final user = ref.watch(userProvider);
  final repository = ref.watch(favoriteRepositoryProvider);
  
  if (user == null) return false;
  
  // This would ideally be cached, but for simplicity we'll check directly
  return repository.isFavorite(user.id, coffeeId);
});
