import 'package:coffe_app_ui/domain/entities/soft_drink.dart';
import 'package:coffe_app_ui/domain/entities/category.dart';

abstract class SoftDrinkRepo {
  Future<List<SoftDrink>> getAll();
  Future<List<SoftDrink>> getByCategory(String categoryId);
  Future<SoftDrink?> getById(String id);
  Future<List<Category>> getCategories();
}
