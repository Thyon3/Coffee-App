import 'package:coffe_app_ui/data/models/coffee_model.dart';

/// Local data source for coffee data
/// Currently provides mock data, can be replaced with local DB later
class CoffeeLocalDataSource {
  static const String _coffeeDescription =
      'Coffee is a beverage brewed from roasted, ground coffee beans, known for its stimulating effect due to caffeine. The most common types of coffee beans are Arabica and Robusta. Arabica beans are prized for their complex, often fruity and floral flavors, while Robusta beans are known for their higher caffeine content and bolder, earthy taste. Beyond the beans, there\'s a wide array of coffee drinks, from simple black coffee and espresso to lattes, cappuccinos, and cold brew variations.';

  static const String _defaultImageUrl =
      'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQA9AMBIgACEQEDEQH/xAAcAAABBQEBAQAAAAAAAAAAAAAEAAIDBQYBBwj/xAA7EAACAQMDAgMECQQDAAEFAAABAgMABBEFEiExQRMiUQZhcYEUIzJCkaGxwfAHUtHhFTPxYiRjcoKS/8QAGAEAAwEBAAAAAAAAAAAAAAAAAQIDAAT/xAAmEQACAgICAgIBBQEAAAAAAAAAAQIRITEDEiJBMlFhE1JxkeEE/9oADAMBAAIRAxEAPwA7T9TsNQH7qUCT/TJw32';

  /// Get all coffees from local data
  Future<List<CoffeeModel>> getAllCoffees() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    return List.generate(
      12,
      (index) => CoffeeModel(
        name: _getCoffeeName(index),
        price: 4.99 + (index * 0.5),
        image: _defaultImageUrl,
        rating: 4.0 + (index % 5) * 0.1,
        type: _getCoffeeType(index),
        description: _coffeeDescription,
      ),
    );
  }

  /// Get available categories
  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    return [
      'All Coffee',
      'Macchiato',
      'Latte',
      'Americano',
      'Cappuccino',
      'Espresso',
      'Mocha',
    ];
  }

  String _getCoffeeName(int index) {
    final names = [
      'Caramel Macchiato',
      'Vanilla Latte',
      'Americano',
      'Cappuccino',
      'Espresso',
      'Mocha Latte',
      'Iced Coffee',
      'Cold Brew',
      'Flat White',
      'Cortado',
      'Irish Coffee',
      'Affogato',
    ];
    return names[index % names.length];
  }

  String _getCoffeeType(int index) {
    final types = [
      'Hot',
      'Iced',
      'Blended',
    ];
    return types[index % types.length];
  }
}
