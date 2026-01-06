import 'package:coffe_app_ui/application/providers/drinks_providers.dart';
import 'package:coffe_app_ui/domain/entities/category.dart';
import 'package:coffe_app_ui/domain/entities/coffee.dart';
import 'package:coffe_app_ui/domain/entities/soft_drink.dart';
import 'package:coffe_app_ui/domain/entities/tea.dart';
import 'package:coffe_app_ui/domain/entities/drink.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Selected category id ("all" by default)
final selectedCategoryIdProvider = StateProvider<String>((ref) => 'all');

// Layout mode: true = grid, false = list
final isGridLayoutProvider = StateProvider<bool>((ref) => true);

// All categories provider (union of drink-specific categories)
final menuCategoriesProvider = FutureProvider<List<Category>>((ref) async {
  final coffeeRepo = ref.read(coffeeRepositoryProviderV2);
  final teaRepo = ref.read(teaRepositoryProvider);
  final softRepo = ref.read(softDrinkRepositoryProvider);

  final lists = await Future.wait([
    coffeeRepo.getCategories(),
    teaRepo.getCategories(),
    softRepo.getCategories(),
  ]);

  final map = <String, Category>{
    'all': const Category(id: 'all', name: 'All'),
  };
  for (final l in lists) {
    for (final c in l) {
      map[c.id] = c;
    }
  }
  return map.values.toList();
});

// All drinks provider (union of all drinks)
final allDrinksProvider = FutureProvider<List<Drink>>((ref) async {
  final coffeeRepo = ref.read(coffeeRepositoryProviderV2);
  final teaRepo = ref.read(teaRepositoryProvider);
  final softRepo = ref.read(softDrinkRepositoryProvider);

  final results = await Future.wait([
    coffeeRepo.getAll(),
    teaRepo.getAll(),
    softRepo.getAll(),
  ]);

  final drinks = <Drink>[];
  drinks.addAll(results[0] as List<Coffee>);
  drinks.addAll(results[1] as List<Tea>);
  drinks.addAll(results[2] as List<SoftDrink>);
  return drinks;
});

// Filtered drinks provider by selected category
final filteredDrinksProvider = FutureProvider<List<Drink>>((ref) async {
  final catId = ref.watch(selectedCategoryIdProvider);
  if (catId == 'all') {
    return ref.watch(allDrinksProvider.future);
  }
  final coffeeRepo = ref.read(coffeeRepositoryProviderV2);
  final teaRepo = ref.read(teaRepositoryProvider);
  final softRepo = ref.read(softDrinkRepositoryProvider);

  final filtered = await Future.wait([
    coffeeRepo.getByCategory(catId),
    teaRepo.getByCategory(catId),
    softRepo.getByCategory(catId),
  ]);
  return <Drink>[...filtered[0], ...filtered[1], ...filtered[2]];
});
