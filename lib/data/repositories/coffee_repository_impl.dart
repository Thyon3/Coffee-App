import 'package:coffe_app_ui/data/datasources/coffee_local_datasource.dart';
import 'package:coffe_app_ui/domain/entities/coffee_entity.dart';
import 'package:coffe_app_ui/domain/entities/search_filter.dart';
import 'package:coffe_app_ui/domain/repositories/coffee_repository.dart';

/// Implementation of CoffeeRepository using local data source
class CoffeeRepositoryImpl implements CoffeeRepository {
  final CoffeeLocalDataSource _localDataSource;

  CoffeeRepositoryImpl(this._localDataSource);

  @override
  Future<List<CoffeeEntity>> getAllCoffees() async {
    try {
      final coffeeModels = await _localDataSource.getAllCoffees();
      return coffeeModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get coffees: $e');
    }
  }

  @override
  Future<CoffeeEntity?> getCoffeeByName(String name) async {
    try {
      final coffees = await getAllCoffees();
      return coffees.firstWhere(
        (coffee) => coffee.name.toLowerCase() == name.toLowerCase(),
        orElse: () => throw Exception('Coffee not found'),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<CoffeeEntity>> getCoffeesByCategory(String category) async {
    try {
      final coffees = await getAllCoffees();
      
      if (category.toLowerCase() == 'all coffee') {
        return coffees;
      }
      
      return coffees.where((coffee) {
        return coffee.name.toLowerCase().contains(category.toLowerCase()) ||
            coffee.type.toLowerCase().contains(category.toLowerCase());
      }).toList();
    } catch (e) {
      throw Exception('Failed to filter coffees: $e');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      return await _localDataSource.getCategories();
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }

  @override
  Future<List<CoffeeEntity>> searchCoffees(SearchFilter filter) async {
    try {
      List<CoffeeEntity> results = await getAllCoffees();

      // Apply search query
      if (filter.query.isNotEmpty) {
        results = results.where((coffee) {
          return coffee.name.toLowerCase().contains(filter.query.toLowerCase()) ||
                 coffee.description.toLowerCase().contains(filter.query.toLowerCase()) ||
                 coffee.type.toLowerCase().contains(filter.query.toLowerCase());
        }).toList();
      }

      // Apply category filter
      if (filter.categories.isNotEmpty) {
        results = results.where((coffee) {
          return filter.categories.any((category) => 
            coffee.type.toLowerCase().contains(category.toLowerCase())
          );
        }).toList();
      }

      // Apply price range filter
      if (filter.minPrice != null) {
        results = results.where((coffee) => 
          coffee.basePrice.amount >= filter.minPrice!
        ).toList();
      }
      if (filter.maxPrice != null) {
        results = results.where((coffee) => 
          coffee.basePrice.amount <= filter.maxPrice!
        ).toList();
      }

      // Apply rating filter
      if (filter.minRating != null) {
        results = results.where((coffee) => 
          coffee.rating >= filter.minRating!
        ).toList();
      }

      // Apply sorting
      results = _sortCoffees(results, filter.sortBy, filter.ascending);

      return results;
    } catch (e) {
      throw Exception('Failed to search coffees: $e');
    }
  }

  @override
  Future<CoffeeEntity?> getCoffeeById(String id) async {
    try {
      final coffees = await getAllCoffees();
      try {
        return coffees.firstWhere((coffee) => coffee.id == id);
      } catch (e) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<CoffeeEntity>> getFeaturedCoffees() async {
    try {
      final coffees = await getAllCoffees();
      // Return top 4 rated coffees
      final sorted = List<CoffeeEntity>.from(coffees);
      sorted.sort((a, b) => b.rating.compareTo(a.rating));
      return sorted.take(4).toList();
    } catch (e) {
      throw Exception('Failed to get featured coffees: $e');
    }
  }

  List<CoffeeEntity> _sortCoffees(List<CoffeeEntity> coffees, String sortBy, bool ascending) {
    final sorted = List<CoffeeEntity>.from(coffees);
    
    switch (sortBy) {
      case 'name':
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'price':
        sorted.sort((a, b) => a.basePrice.amount.compareTo(b.basePrice.amount));
        break;
      case 'rating':
        sorted.sort((a, b) => a.rating.compareTo(b.rating));
        break;
    }
    
    if (!ascending) {
      return sorted.reversed.toList();
    }
    
    return sorted;
  }
}
