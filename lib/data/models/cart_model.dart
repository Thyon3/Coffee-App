import 'package:coffe_app_ui/domain/entities/cart.dart';
import 'package:coffe_app_ui/domain/entities/cart_item.dart';
import 'package:coffe_app_ui/data/models/cart_item_model.dart';

class CartModel {
  final List<CartItemModel> items;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CartModel({
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Cart toEntity() {
    return Cart(
      items: items.map((item) => item.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory CartModel.fromEntity(Cart cart) {
    return CartModel(
      items: cart.items.map((item) => CartItemModel.fromEntity(item)).toList(),
      createdAt: cart.createdAt,
      updatedAt: cart.updatedAt,
    );
  }
}
