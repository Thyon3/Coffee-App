import 'package:coffe_app_ui/domain/entities/coffee_entity.dart';

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
}
