import 'package:equatable/equatable.dart';
import 'package:coffe_app_ui/domain/value_objects/price.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';

abstract class Drink extends Equatable {
  const Drink({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.basePrice,
    this.availableSizes = const [DrinkSize.small(), DrinkSize.medium(), DrinkSize.large()],
  });

  final String id;
  final String name;
  final String description;
  final String image; // can be asset path or URL for mock use
  final Price basePrice;
  final List<DrinkSize> availableSizes;

  @override
  List<Object?> get props => [id, name, description, image, basePrice, availableSizes];
}
