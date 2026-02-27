import 'package:coffe_app_ui/domain/entities/favorite.dart';
import 'package:coffe_app_ui/domain/entities/coffee_entity.dart';

abstract class FavoriteRepository {
  /// Get all favorites for a user
  Future<List<Favorite>> getUserFavorites(String userId);
  
  /// Get all favorite coffees for a user
  Future<List<CoffeeEntity>> getFavoriteCoffees(String userId);
  
  /// Add a coffee to favorites
  Future<Favorite> addToFavorites(String userId, String coffeeId);
  
  /// Remove a coffee from favorites
  Future<void> removeFromFavorites(String userId, String coffeeId);
  
  /// Check if a coffee is in user's favorites
  Future<bool> isFavorite(String userId, String coffeeId);
  
  /// Toggle favorite status
  Future<bool> toggleFavorite(String userId, String coffeeId);
}
