import 'package:coffe_app_ui/domain/entities/category.dart';
import 'package:coffe_app_ui/domain/entities/coffee.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';
import 'package:coffe_app_ui/domain/value_objects/price.dart';

class CoffeeMockDataSource {
  const CoffeeMockDataSource();

  Future<List<Category>> getCategories() async => const [
        Category(id: 'all', name: 'All'),
        Category(id: 'latte', name: 'Latte'),
        Category(id: 'americano', name: 'Americano'),
        Category(id: 'cappuccino', name: 'Cappuccino'),
      ];

  Future<List<Coffee>> getAll() async => [
        Coffee(
          id: 'c1',
          name: 'Vanilla Latte',
          description: 'Smooth espresso with vanilla and steamed milk',
          image: 'data:image/jpeg;base64,',
          basePrice: const Price(amount: 4.99),
          availableSizes: const [DrinkSize.small(), DrinkSize.medium(), DrinkSize.large()],
          roast: 'Medium',
          origin: 'Ethiopia',
          type: 'Latte',
        ),
        Coffee(
          id: 'c2',
          name: 'Americano',
          description: 'Espresso with hot water',
          image: 'data:image/jpeg;base64,',
          basePrice: const Price(amount: 3.49),
          type: 'Americano',
        ),
        Coffee(
          id: 'c3',
          name: 'Cappuccino',
          description: 'Espresso with steamed milk foam',
          image: 'data:image/jpeg;base64,',
          basePrice: const Price(amount: 4.49),
          type: 'Cappuccino',
        ),
      ];
}
