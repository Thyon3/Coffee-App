import 'package:flutter_test/flutter_test.dart';
import 'package:coffe_app_ui/domain/entities/cart.dart';
import 'package:coffe_app_ui/domain/entities/cart_item.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';
import 'package:coffe_app_ui/domain/value_objects/price.dart';
import 'package:coffe_app_ui/domain/value_objects/extra.dart';

void main() {
  group('Cart Entity Tests', () {
    test('should create empty cart', () {
      final cart = const Cart.empty();
      
      expect(cart.items.isEmpty, true);
      expect(cart.totalItems, 0);
      expect(cart.totalPrice.amount, 0.0);
      expect(cart.isEmpty, true);
      expect(cart.isNotEmpty, false);
    });

    test('should add item to cart', () {
      final cart = const Cart.empty();
      final item = CartItem(
        id: 'test-item-1',
        drinkId: 'coffee-1',
        drinkName: 'Espresso',
        image: 'test.jpg',
        basePrice: 2.99,
        size: const DrinkSize.medium(),
        extras: [],
        quantity: 1,
      );

      final updatedCart = cart.addItem(item);

      expect(updatedCart.items.length, 1);
      expect(updatedCart.totalItems, 1);
      expect(updatedCart.totalPrice.amount, 2.99);
      expect(updatedCart.isEmpty, false);
      expect(updatedCart.isNotEmpty, true);
    });

    test('should update item quantity', () {
      final cart = const Cart.empty();
      final item = CartItem(
        id: 'test-item-1',
        drinkId: 'coffee-1',
        drinkName: 'Espresso',
        image: 'test.jpg',
        basePrice: 2.99,
        size: const DrinkSize.medium(),
        extras: [],
        quantity: 1,
      );

      final cartWithItem = cart.addItem(item);
      final updatedCart = cartWithItem.updateItemQuantity('test-item-1', 3);

      expect(updatedCart.items.first.quantity, 3);
      expect(updatedCart.totalItems, 3);
      expect(updatedCart.totalPrice.amount, 8.97); // 2.99 * 3
    });

    test('should remove item from cart', () {
      final cart = const Cart.empty();
      final item = CartItem(
        id: 'test-item-1',
        drinkId: 'coffee-1',
        drinkName: 'Espresso',
        image: 'test.jpg',
        basePrice: 2.99,
        size: const DrinkSize.medium(),
        extras: [],
        quantity: 1,
      );

      final cartWithItem = cart.addItem(item);
      final updatedCart = cartWithItem.removeItem('test-item-1');

      expect(updatedCart.items.isEmpty, true);
      expect(updatedCart.totalItems, 0);
      expect(updatedCart.totalPrice.amount, 0.0);
    });

    test('should clear all items from cart', () {
      final cart = const Cart.empty();
      final item = CartItem(
        id: 'test-item-1',
        drinkId: 'coffee-1',
        drinkName: 'Espresso',
        image: 'test.jpg',
        basePrice: 2.99,
        size: const DrinkSize.medium(),
        extras: [],
        quantity: 1,
      );

      final cartWithItem = cart.addItem(item);
      final clearedCart = cartWithItem.clear();

      expect(clearedCart.items.isEmpty, true);
      expect(clearedCart.totalItems, 0);
      expect(clearedCart.totalPrice.amount, 0.0);
    });
  });
}
