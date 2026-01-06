import 'package:coffe_app_ui/domain/entities/tea.dart';
import 'package:coffe_app_ui/domain/entities/category.dart';

abstract class TeaRepo {
  Future<List<Tea>> getAll();
  Future<List<Tea>> getByCategory(String categoryId);
  Future<Tea?> getById(String id);
  Future<List<Category>> getCategories();
}
