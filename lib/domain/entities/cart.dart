import 'package:equatable/equatable.dart';
import 'package:coffe_app_ui/domain/entities/cart_item.dart';
import 'package:coffe_app_ui/domain/value_objects/price.dart';

class Cart extends Equatable {
  final List<CartItem> items;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Cart({
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });

  const Cart.empty()
      : items = const [],
        createdAt = const Duration(milliseconds: 0).isEmpty
            ? DateTime.now()
            : DateTime.now(),
        updatedAt = const Duration(milliseconds: 0).isEmpty
            ? DateTime.now()
            : DateTime.now();

  Cart copyWith({
    List<CartItem>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Cart(
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? updatedAt ?? DateTime.now(),
    );
  }

  /// Add an item to the cart or update quantity if it already exists
  Cart addItem(CartItem item) {
    final existingIndex = items.indexWhere((i) => i.id == item.id);
    
    if (existingIndex != -1) {
      // Update existing item quantity
      final updatedItems = List<CartItem>.from(items);
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + item.quantity,
      );
      return copyWith(items: updatedItems);
    } else {
      // Add new item
      return copyWith(items: [...items, item]);
    }
  }

  /// Remove an item from the cart
  Cart removeItem(String itemId) {
    return copyWith(items: items.where((item) => item.id != itemId).toList());
  }

  /// Update item quantity
  Cart updateItemQuantity(String itemId, int quantity) {
    if (quantity <= 0) return removeItem(itemId);
    
    final updatedItems = items.map((item) {
      return item.id == itemId ? item.copyWith(quantity: quantity) : item;
    }).toList();
    
    return copyWith(items: updatedItems);
  }

  /// Clear all items from cart
  Cart clear() {
    return copyWith(items: const []);
  }

  /// Calculate total price of all items
  Price get totalPrice {
    final total = items.fold<double>(
      0.0,
      (sum, item) => sum + (item.basePrice * item.quantity),
    );
    return Price(amount: total);
  }

  /// Get total number of items
  int get totalItems => items.fold<int>(
        0,
        (sum, item) => sum + item.quantity,
      );

  /// Check if cart is empty
  bool get isEmpty => items.isEmpty;

  /// Check if cart is not empty
  bool get isNotEmpty => items.isNotEmpty;

  @override
  List<Object?> get props => [items, createdAt, updatedAt];
}
