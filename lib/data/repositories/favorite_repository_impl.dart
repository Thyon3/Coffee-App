import 'dart:convert';
import 'dart:math';
import 'package:coffe_app_ui/domain/entities/favorite.dart';
import 'package:coffe_app_ui/domain/entities/coffee_entity.dart';
import 'package:coffe_app_ui/domain/repositories/favorite_repository.dart';
import 'package:coffe_app_ui/domain/value_objects/price.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  static const String _favoritesKey = 'user_favorites';
  
  @override
  Future<List<Favorite>> getUserFavorites(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getString('${_favoritesKey}_$userId');
      
      if (favoritesJson == null) {
        return [];
      }
      
      final List<dynamic> favoritesList = jsonDecode(favoritesJson);
      return favoritesList.map((json) => Favorite(
        id: json['id'] as String,
        userId: json['userId'] as String,
        coffeeId: json['coffeeId'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
      )).toList();
    } catch (e) {
      return [];
    }
  }
  
  @override
  Future<List<CoffeeEntity>> getFavoriteCoffees(String userId) async {
    final favorites = await getUserFavorites(userId);
    
    // Mock coffee data - in a real app, this would fetch from API
    final mockCoffees = _getMockCoffees();
    
    return mockCoffees.where((coffee) {
      return favorites.any((favorite) => favorite.coffeeId == coffee.id);
    }).toList();
  }
  
  @override
  Future<Favorite> addToFavorites(String userId, String coffeeId) async {
    final favorites = await getUserFavorites(userId);
    
    // Check if already favorited
    if (favorites.any((fav) => fav.coffeeId == coffeeId)) {
      throw Exception('Coffee already in favorites');
    }
    
    final newFavorite = Favorite(
      id: 'fav_${Random().nextInt(10000)}',
      userId: userId,
      coffeeId: coffeeId,
      createdAt: DateTime.now(),
    );
    
    final updatedFavorites = [...favorites, newFavorite];
    await _saveFavorites(userId, updatedFavorites);
    
    return newFavorite;
  }
  
  @override
  Future<void> removeFromFavorites(String userId, String coffeeId) async {
    final favorites = await getUserFavorites(userId);
    final updatedFavorites = favorites.where((fav) => fav.coffeeId != coffeeId).toList();
    await _saveFavorites(userId, updatedFavorites);
  }
  
  @override
  Future<bool> isFavorite(String userId, String coffeeId) async {
    final favorites = await getUserFavorites(userId);
    return favorites.any((fav) => fav.coffeeId == coffeeId);
  }
  
  @override
  Future<bool> toggleFavorite(String userId, String coffeeId) async {
    final isFav = await isFavorite(userId, coffeeId);
    
    if (isFav) {
      await removeFromFavorites(userId, coffeeId);
      return false;
    } else {
      await addToFavorites(userId, coffeeId);
      return true;
    }
  }
  
  Future<void> _saveFavorites(String userId, List<Favorite> favorites) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = jsonEncode(
        favorites.map((fav) => {
          'id': fav.id,
          'userId': fav.userId,
          'coffeeId': fav.coffeeId,
          'createdAt': fav.createdAt.toIso8601String(),
        }).toList(),
      );
      await prefs.setString('${_favoritesKey}_$userId', favoritesJson);
    } catch (e) {
      rethrow;
    }
  }
  
  List<CoffeeEntity> _getMockCoffees() {
    return [
      CoffeeEntity(
        id: 'coffee_1',
        name: 'Espresso',
        description: 'Strong and bold espresso shot',
        image: 'https://via.placeholder.com/300x200/8B4513/FFFFFF?text=Espresso',
        basePrice: const Price(amount: 2.99),
        rating: 4.5,
        type: 'Espresso',
      ),
      CoffeeEntity(
        id: 'coffee_2',
        name: 'Cappuccino',
        description: 'Espresso with steamed milk and foam',
        image: 'https://via.placeholder.com/300x200/D2691E/FFFFFF?text=Cappuccino',
        basePrice: const Price(amount: 4.99),
        rating: 4.7,
        type: 'Cappuccino',
      ),
      CoffeeEntity(
        id: 'coffee_3',
        name: 'Latte',
        description: 'Smooth espresso with steamed milk',
        image: 'https://via.placeholder.com/300x200/DEB887/FFFFFF?text=Latte',
        basePrice: const Price(amount: 5.49),
        rating: 4.6,
        type: 'Latte',
      ),
      CoffeeEntity(
        id: 'coffee_4',
        name: 'Americano',
        description: 'Espresso with hot water',
        image: 'https://via.placeholder.com/300x200/A0522D/FFFFFF?text=Americano',
        basePrice: const Price(amount: 3.49),
        rating: 4.4,
        type: 'Americano',
      ),
      CoffeeEntity(
        id: 'coffee_5',
        name: 'Mocha',
        description: 'Espresso with chocolate and steamed milk',
        image: 'https://via.placeholder.com/300x200/8B4513/FFFFFF?text=Mocha',
        basePrice: const Price(amount: 5.99),
        rating: 4.8,
        type: 'Mocha',
      ),
    ];
  }
}
