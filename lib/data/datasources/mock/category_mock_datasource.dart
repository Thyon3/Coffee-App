import 'package:coffe_app_ui/domain/entities/category.dart';

class CategoryMockDataSource {
  const CategoryMockDataSource();

  Future<List<Category>> getAll() async => const [
        Category(id: 'coffee', name: 'Coffee'),
        Category(id: 'tea', name: 'Tea'),
        Category(id: 'soft', name: 'Soft Drinks'),
      ];

  Future<Category?> getById(String id) async {
    final all = await getAll();
    try {
      return all.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }
}
