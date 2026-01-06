import 'package:coffe_app_ui/data/datasources/coffee_local_datasource.dart';
import 'package:coffe_app_ui/domain/entities/coffee_entity.dart';
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
}
