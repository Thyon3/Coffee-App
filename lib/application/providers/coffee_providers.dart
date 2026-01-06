import 'package:coffe_app_ui/data/datasources/coffee_local_datasource.dart';
import 'package:coffe_app_ui/data/repositories/coffee_repository_impl.dart';
import 'package:coffe_app_ui/domain/entities/coffee_entity.dart';
import 'package:coffe_app_ui/domain/repositories/coffee_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ========== Data Source Provider ==========
final coffeeLocalDataSourceProvider = Provider<CoffeeLocalDataSource>((ref) {
  return CoffeeLocalDataSource();
});

// ========== Repository Provider ==========
final coffeeRepositoryProvider = Provider<CoffeeRepository>((ref) {
  final dataSource = ref.watch(coffeeLocalDataSourceProvider);
  return CoffeeRepositoryImpl(dataSource);
});

// ========== Coffee List Provider ==========
final coffeeListProvider = FutureProvider<List<CoffeeEntity>>((ref) async {
  final repository = ref.watch(coffeeRepositoryProvider);
  return await repository.getAllCoffees();
});

// ========== Categories Provider ==========
final categoriesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(coffeeRepositoryProvider);
  return await repository.getCategories();
});

// ========== Selected Category Provider ==========
final selectedCategoryProvider = StateProvider<int>((ref) => 0);

// ========== Filtered Coffee List Provider ==========
final filteredCoffeeListProvider = FutureProvider<List<CoffeeEntity>>((ref) async {
  final repository = ref.watch(coffeeRepositoryProvider);
  final selectedIndex = ref.watch(selectedCategoryProvider);
  final categories = await ref.watch(categoriesProvider.future);
  
  if (selectedIndex >= categories.length) {
    return await repository.getAllCoffees();
  }
  
  final selectedCategory = categories[selectedIndex];
  return await repository.getCoffeesByCategory(selectedCategory);
});
