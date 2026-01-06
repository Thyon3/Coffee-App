import 'package:coffe_app_ui/domain/entities/category.dart';
import 'package:coffe_app_ui/domain/entities/tea.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';
import 'package:coffe_app_ui/domain/value_objects/price.dart';

class TeaMockDataSource {
  const TeaMockDataSource();

  Future<List<Category>> getCategories() async => const [
        Category(id: 'all', name: 'All'),
        Category(id: 'black', name: 'Black Tea'),
        Category(id: 'green', name: 'Green Tea'),
        Category(id: 'herbal', name: 'Herbal'),
      ];

  Future<List<Tea>> getAll() async => [
        Tea(
          id: 't1',
          name: 'Earl Grey',
          description: 'Black tea with bergamot',
          image: 'data:image/jpeg;base64,',
          basePrice: const Price(amount: 2.99),
          availableSizes: const [DrinkSize.small(), DrinkSize.medium(), DrinkSize.large()],
          leafType: 'Black',
        ),
        Tea(
          id: 't2',
          name: 'Matcha',
          description: 'Finely ground green tea',
          image: 'data:image/jpeg;base64,',
          basePrice: const Price(amount: 3.99),
          leafType: 'Green',
          isIced: false,
        ),
        Tea(
          id: 't3',
          name: 'Chamomile',
          description: 'Relaxing herbal infusion',
          image: 'data:image/jpeg;base64,',
          basePrice: const Price(amount: 2.49),
          leafType: 'Herbal',
        ),
      ];
}
