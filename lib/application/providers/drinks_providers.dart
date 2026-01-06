import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:coffe_app_ui/data/datasources/mock/coffee_mock_datasource.dart';
import 'package:coffe_app_ui/data/datasources/mock/tea_mock_datasource.dart';
import 'package:coffe_app_ui/data/datasources/mock/soft_drink_mock_datasource.dart';
import 'package:coffe_app_ui/data/datasources/mock/category_mock_datasource.dart';

import 'package:coffe_app_ui/data/repositories/drinks/coffee_repository_impl.dart';
import 'package:coffe_app_ui/data/repositories/drinks/tea_repository_impl.dart';
import 'package:coffe_app_ui/data/repositories/drinks/soft_drink_repository_impl.dart';
import 'package:coffe_app_ui/data/repositories/drinks/category_repository_impl.dart';

import 'package:coffe_app_ui/domain/repositories/drinks/coffee_repository.dart';
import 'package:coffe_app_ui/domain/repositories/drinks/tea_repository.dart';
import 'package:coffe_app_ui/domain/repositories/drinks/soft_drink_repository.dart';
import 'package:coffe_app_ui/domain/repositories/drinks/category_repository.dart';

// Data source providers (mock for local dev)
final coffeeMockDataSourceProvider = Provider((ref) => const CoffeeMockDataSource());
final teaMockDataSourceProvider = Provider((ref) => const TeaMockDataSource());
final softDrinkMockDataSourceProvider = Provider((ref) => const SoftDrinkMockDataSource());
final categoryMockDataSourceProvider = Provider((ref) => const CategoryMockDataSource());

// Repository providers
final coffeeRepositoryProviderV2 = Provider<CoffeeRepo>((ref) {
  final ds = ref.watch(coffeeMockDataSourceProvider);
  return CoffeeRepositoryImpl(ds);
});

final teaRepositoryProvider = Provider<TeaRepo>((ref) {
  final ds = ref.watch(teaMockDataSourceProvider);
  return TeaRepositoryImpl(ds);
});

final softDrinkRepositoryProvider = Provider<SoftDrinkRepo>((ref) {
  final ds = ref.watch(softDrinkMockDataSourceProvider);
  return SoftDrinkRepositoryImpl(ds);
});

final categoryRepositoryProvider = Provider<CategoryRepo>((ref) {
  final ds = ref.watch(categoryMockDataSourceProvider);
  return CategoryRepositoryImpl(ds);
});
