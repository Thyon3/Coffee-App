import 'package:coffe_app_ui/domain/entities/drink.dart';

class Coffee extends Drink {
  const Coffee({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.basePrice,
    super.availableSizes,
    this.roast = 'Medium',
    this.origin,
    this.type = 'Coffee',
  });

  final String roast; // e.g., Light, Medium, Dark
  final String? origin; // e.g., Ethiopia
  final String type; // e.g., Latte, Americano, Cappuccino
}
