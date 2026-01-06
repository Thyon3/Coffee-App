import 'package:coffe_app_ui/data/datasources/mock/tea_mock_datasource.dart';
import 'package:coffe_app_ui/domain/entities/category.dart';
import 'package:coffe_app_ui/domain/entities/tea.dart';
import 'package:coffe_app_ui/domain/repositories/drinks/tea_repository.dart';

class TeaRepositoryImpl implements TeaRepo {
  TeaRepositoryImpl(this._ds);
  final TeaMockDataSource _ds;

  @override
  Future<List<Tea>> getAll() => _ds.getAll();

  @override
  Future<Tea?> getById(String id) async {
    final data = await _ds.getAll();
    try {
      return data.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Tea>> getByCategory(String categoryId) async {
    if (categoryId == 'all') return _ds.getAll();
    final data = await _ds.getAll();
    final key = categoryId.toLowerCase();
    return data.where((e) => e.leafType.toLowerCase().contains(key) || e.name.toLowerCase().contains(key)).toList();
  }

  @override
  Future<List<Category>> getCategories() => _ds.getCategories();
}
