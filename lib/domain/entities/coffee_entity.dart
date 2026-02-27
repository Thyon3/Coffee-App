import 'package:equatable/equatable.dart';
import 'package:coffe_app_ui/domain/entities/drink.dart';
import 'package:coffe_app_ui/domain/value_objects/price.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';

/// Domain entity representing a Coffee item
/// This is the core business object independent of any framework or UI
class CoffeeEntity extends Drink {
  const CoffeeEntity({
    required this.id,
    required super.name,
    required super.description,
    required super.image,
    required super.basePrice,
    this.rating = 0.0,
    this.type = 'Coffee',
    super.availableSizes = const [
      DrinkSize.small(),
      DrinkSize.medium(),
      DrinkSize.large(),
    ],
  });

  final String id;
  final double rating;
  final String type;

  @override
  List<Object?> get props => [
        id,
        name,
        basePrice,
        image,
        rating,
        type,
        description,
        availableSizes,
      ];

  CoffeeEntity copyWith({
    String? id,
    String? name,
    Price? basePrice,
    String? image,
    double? rating,
    String? type,
    String? description,
    List<DrinkSize>? availableSizes,
  }) {
    return CoffeeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      basePrice: basePrice ?? this.basePrice,
      rating: rating ?? this.rating,
      type: type ?? this.type,
      availableSizes: availableSizes ?? this.availableSizes,
    );
  }
}
