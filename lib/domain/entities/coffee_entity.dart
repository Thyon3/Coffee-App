import 'package:equatable/equatable.dart';

/// Domain entity representing a Coffee item
/// This is the core business object independent of any framework or UI
class CoffeeEntity extends Equatable {
  const CoffeeEntity({
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
    required this.type,
    required this.description,
  });

  final String name;
  final double price;
  final String image;
  final double rating;
  final String type;
  final String description;

  @override
  List<Object?> get props => [
        name,
        price,
        image,
        rating,
        type,
        description,
      ];

  CoffeeEntity copyWith({
    String? name,
    double? price,
    String? image,
    double? rating,
    String? type,
    String? description,
  }) {
    return CoffeeEntity(
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }
}
