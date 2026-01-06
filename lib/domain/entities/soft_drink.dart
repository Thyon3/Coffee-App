import 'package:coffe_app_ui/domain/entities/drink.dart';

class SoftDrink extends Drink {
  const SoftDrink({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.basePrice,
    super.availableSizes,
    this.isDiet = false,
    this.flavor = 'Cola',
  });

  final bool isDiet;
  final String flavor;
}
