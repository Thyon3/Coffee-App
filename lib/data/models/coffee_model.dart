import 'package:coffe_app_ui/domain/entities/coffee_entity.dart';

/// Data model for Coffee that can be serialized/deserialized
/// Extends domain entity and adds data layer specific functionality
class CoffeeModel extends CoffeeEntity {
  const CoffeeModel({
    required super.name,
    required super.price,
    required super.image,
    required super.rating,
    required super.type,
    required super.description,
  });

  /// Create from domain entity
  factory CoffeeModel.fromEntity(CoffeeEntity entity) {
    return CoffeeModel(
      name: entity.name,
      price: entity.price,
      image: entity.image,
      rating: entity.rating,
      type: entity.type,
      description: entity.description,
    );
  }

  /// Convert to domain entity
  CoffeeEntity toEntity() {
    return CoffeeEntity(
      name: name,
      price: price,
      image: image,
      rating: rating,
      type: type,
      description: description,
    );
  }

  /// Create from JSON (for future API integration)
  factory CoffeeModel.fromJson(Map<String, dynamic> json) {
    return CoffeeModel(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      rating: (json['rating'] as num).toDouble(),
      type: json['type'] as String,
      description: json['description'] as String,
    );
  }

  /// Convert to JSON (for future API integration)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'rating': rating,
      'type': type,
      'description': description,
    };
  }
}
