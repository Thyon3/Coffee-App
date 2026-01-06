import 'package:coffe_app_ui/data/datasources/mock/coffee_mock_datasource.dart';
import 'package:coffe_app_ui/domain/entities/category.dart';
import 'package:coffe_app_ui/domain/entities/coffee.dart';
import 'package:coffe_app_ui/domain/repositories/drinks/coffee_repository.dart';

class CoffeeRepositoryImpl implements CoffeeRepo {
  CoffeeRepositoryImpl(this._ds);
  final CoffeeMockDataSource _ds;

  @override
  Future<List<Coffee>> getAll() => _ds.getAll();

  @override
  Future<Coffee?> getById(String id) async {
    final data = await _ds.getAll();
    try {
      return data.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Coffee>> getByCategory(String categoryId) async {
    if (categoryId == 'all') return _ds.getAll();
    final data = await _ds.getAll();
    return data.where((e) => e.name.toLowerCase().contains(categoryId) || e is Coffee && (e as Coffee).type.toLowerCase() == categoryId).toList();
  }

  @override
  Future<List<Category>> getCategories() => _ds.getCategories();
}
