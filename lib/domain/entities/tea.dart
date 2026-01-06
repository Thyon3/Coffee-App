import 'package:coffe_app_ui/domain/entities/drink.dart';

class Tea extends Drink {
  const Tea({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.basePrice,
    super.availableSizes,
    this.leafType = 'Black', // Black, Green, Herbal, etc.
    this.isIced = false,
  });

  final String leafType;
  final bool isIced;
}
