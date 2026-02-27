import 'package:coffe_app_ui/domain/entities/cart_item.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';
import 'package:coffe_app_ui/domain/value_objects/extra.dart';
import 'package:coffe_app_ui/domain/value_objects/price.dart';

class CartItemModel {
  final String id;
  final String drinkId;
  final String drinkName;
  final String image;
  final double basePrice;
  final DrinkSize size;
  final List<Extra> extras;
  final int quantity;

  const CartItemModel({
    required this.id,
    required this.drinkId,
    required this.drinkName,
    required this.image,
    required this.basePrice,
    required this.size,
    required this.extras,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      drinkId: json['drinkId'] as String,
      drinkName: json['drinkName'] as String,
      image: json['image'] as String,
      basePrice: (json['basePrice'] as num).toDouble(),
      size: _drinkSizeFromJson(json['size'] as Map<String, dynamic>),
      extras: (json['extras'] as List<dynamic>?)
          ?.map((extra) => _extraFromJson(extra as Map<String, dynamic>))
          .toList() ?? [],
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'drinkId': drinkId,
      'drinkName': drinkName,
      'image': image,
      'basePrice': basePrice,
      'size': _drinkSizeToJson(size),
      'extras': extras.map((extra) => _extraToJson(extra)).toList(),
      'quantity': quantity,
    };
  }

  CartItem toEntity() {
    return CartItem(
      id: id,
      drinkId: drinkId,
      drinkName: drinkName,
      image: image,
      basePrice: basePrice,
      size: size,
      extras: extras,
      quantity: quantity,
    );
  }

  factory CartItemModel.fromEntity(CartItem cartItem) {
    return CartItemModel(
      id: cartItem.id,
      drinkId: cartItem.drinkId,
      drinkName: cartItem.drinkName,
      image: cartItem.image,
      basePrice: cartItem.basePrice,
      size: cartItem.size,
      extras: cartItem.extras,
      quantity: cartItem.quantity,
    );
  }

  static DrinkSize _drinkSizeFromJson(Map<String, dynamic> json) {
    final type = DrinkSizeType.values.firstWhere(
      (e) => e.name == json['type'] as String,
      orElse: () => DrinkSizeType.medium,
    );
    return DrinkSize(type: type, volumeMl: json['volumeMl'] as double);
  }

  static Map<String, dynamic> _drinkSizeToJson(DrinkSize size) {
    return {
      'type': size.type.name,
      'volumeMl': size.volumeMl,
    };
  }

  static Extra _extraFromJson(Map<String, dynamic> json) {
    return Extra(
      id: json['id'] as String,
      name: json['name'] as String,
      price: Price(amount: (json['price'] as num).toDouble()),
    );
  }

  static Map<String, dynamic> _extraToJson(Extra extra) {
    return {
      'id': extra.id,
      'name': extra.name,
      'price': extra.price.amount,
    };
  }
}
