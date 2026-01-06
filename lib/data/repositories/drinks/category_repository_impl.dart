import 'package:coffe_app_ui/data/datasources/mock/category_mock_datasource.dart';
import 'package:coffe_app_ui/domain/entities/category.dart';
import 'package:coffe_app_ui/domain/repositories/drinks/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepo {
  CategoryRepositoryImpl(this._ds);
  final CategoryMockDataSource _ds;

  @override
  Future<List<Category>> getAll() => _ds.getAll();

  @override
  Future<Category?> getById(String id) => _ds.getById(id);
}
