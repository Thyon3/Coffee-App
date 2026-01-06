import 'package:coffe_app_ui/domain/entities/category.dart';

abstract class CategoryRepo {
  Future<List<Category>> getAll();
  Future<Category?> getById(String id);
}
