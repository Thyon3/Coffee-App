import 'package:coffe_app_ui/domain/entities/coffee_entity.dart';
import 'package:coffe_app_ui/domain/entities/search_filter.dart';

/// Repository interface for Coffee operations
/// This defines the contract that data layer must implement
abstract class CoffeeRepository {
  /// Get all available coffees
  Future<List<CoffeeEntity>> getAllCoffees();

  /// Get coffee by name
  Future<CoffeeEntity?> getCoffeeByName(String name);

  /// Get coffees filtered by category
  Future<List<CoffeeEntity>> getCoffeesByCategory(String category);

  /// Get all available categories
  Future<List<String>> getCategories();
  
  /// Search coffees with filters
  Future<List<CoffeeEntity>> searchCoffees(SearchFilter filter);
  
  /// Get coffee by ID
  Future<CoffeeEntity?> getCoffeeById(String id);
  
  /// Get featured coffees
  Future<List<CoffeeEntity>> getFeaturedCoffees();
}
