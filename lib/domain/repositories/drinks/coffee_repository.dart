import 'package:coffe_app_ui/domain/entities/coffee.dart';
import 'package:coffe_app_ui/domain/entities/category.dart';

abstract class CoffeeRepo {
  Future<List<Coffee>> getAll();
  Future<List<Coffee>> getByCategory(String categoryId);
  Future<Coffee?> getById(String id);
  Future<List<Category>> getCategories();
}
