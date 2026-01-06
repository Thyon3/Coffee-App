import 'package:coffe_app_ui/data/datasources/mock/soft_drink_mock_datasource.dart';
import 'package:coffe_app_ui/domain/entities/category.dart';
import 'package:coffe_app_ui/domain/entities/soft_drink.dart';
import 'package:coffe_app_ui/domain/repositories/drinks/soft_drink_repository.dart';

class SoftDrinkRepositoryImpl implements SoftDrinkRepo {
  SoftDrinkRepositoryImpl(this._ds);
  final SoftDrinkMockDataSource _ds;

  @override
  Future<List<SoftDrink>> getAll() => _ds.getAll();

  @override
  Future<SoftDrink?> getById(String id) async {
    final data = await _ds.getAll();
    try {
      return data.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<SoftDrink>> getByCategory(String categoryId) async {
    if (categoryId == 'all') return _ds.getAll();
    final data = await _ds.getAll();
    final key = categoryId.toLowerCase();
    return data.where((e) => e.flavor.toLowerCase().contains(key) || e.name.toLowerCase().contains(key)).toList();
  }

  @override
  Future<List<Category>> getCategories() => _ds.getCategories();
}
