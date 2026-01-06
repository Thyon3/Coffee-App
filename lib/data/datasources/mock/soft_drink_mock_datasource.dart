import 'package:coffe_app_ui/domain/entities/category.dart';
import 'package:coffe_app_ui/domain/entities/soft_drink.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';
import 'package:coffe_app_ui/domain/value_objects/price.dart';

class SoftDrinkMockDataSource {
  const SoftDrinkMockDataSource();

  Future<List<Category>> getCategories() async => const [
        Category(id: 'all', name: 'All'),
        Category(id: 'cola', name: 'Cola'),
        Category(id: 'orange', name: 'Orange'),
        Category(id: 'lemon', name: 'Lemon'),
      ];

  Future<List<SoftDrink>> getAll() async => [
    SoftDrink(
      id: 's1',
      name: 'Cola Classic',
      description: 'Carbonated cola beverage',
      image: 'data:image/jpeg;base64,',
      basePrice: const Price(amount: 1.99),
      availableSizes: const [DrinkSize.small(), DrinkSize.medium(), DrinkSize.large()],
      flavor: 'Cola',
      isDiet: false,
    ),
    SoftDrink(
      id: 's2',
      name: 'Diet Cola',
      description: 'Zero sugar cola',
      image: 'data:image/jpeg;base64,',
      basePrice: const Price(amount: 1.99),
      flavor: 'Cola',
      isDiet: true,
    ),
    SoftDrink(
      id: 's3',
      name: 'Orange Soda',
      description: 'Citrus flavored soft drink',
      image: 'data:image/jpeg;base64,',
      basePrice: const Price(amount: 1.79),
      flavor: 'Orange',
    ),
  ];
}
