import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffe_app_ui/provider/cart_provider.dart';
import 'package:coffe_app_ui/domain/entities/cart.dart';
import 'package:coffe_app_ui/domain/entities/cart_item.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';

void main() {
  group('Cart Provider Tests', () {
    testWidgets('should initialize with empty cart', (WidgetTester tester) async {
      final container = ProviderContainer(
        overrides: [],
      );

      final cartState = container.read(cartNotifierProvider);

      expect(cartState.cart.items.isEmpty, true);
      expect(cartState.isLoading, false);
      expect(cartState.error, null);

      container.dispose();
    });

    testWidgets('should add item to cart', (WidgetTester tester) async {
      final container = ProviderContainer(
        overrides: [],
      );

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

      await container.read(cartNotifierProvider.notifier).addItem(item);

      final cartState = container.read(cartNotifierProvider);
      expect(cartState.cart.items.length, 1);
      expect(cartState.cart.totalItems, 1);
      expect(cartState.cart.totalPrice.amount, 2.99);

      container.dispose();
    });

    testWidgets('should update item quantity', (WidgetTester tester) async {
      final container = ProviderContainer(
        overrides: [],
      );

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

      await container.read(cartNotifierProvider.notifier).addItem(item);
      await container.read(cartNotifierProvider.notifier).updateItemQuantity('test-item-1', 3);

      final cartState = container.read(cartNotifierProvider);
      expect(cartState.cart.items.first.quantity, 3);
      expect(cartState.cart.totalItems, 3);
      expect(cartState.cart.totalPrice.amount, 8.97);

      container.dispose();
    });

    testWidgets('should remove item from cart', (WidgetTester tester) async {
      final container = ProviderContainer(
        overrides: [],
      );

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

      await container.read(cartNotifierProvider.notifier).addItem(item);
      await container.read(cartNotifierProvider.notifier).removeItem('test-item-1');

      final cartState = container.read(cartNotifierProvider);
      expect(cartState.cart.items.isEmpty, true);
      expect(cartState.cart.totalItems, 0);
      expect(cartState.cart.totalPrice.amount, 0.0);

      container.dispose();
    });

    testWidgets('should clear cart', (WidgetTester tester) async {
      final container = ProviderContainer(
        overrides: [],
      );

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

      await container.read(cartNotifierProvider.notifier).addItem(item);
      await container.read(cartNotifierProvider.notifier).clearCart();

      final cartState = container.read(cartNotifierProvider);
      expect(cartState.cart.items.isEmpty, true);
      expect(cartState.cart.totalItems, 0);
      expect(cartState.cart.totalPrice.amount, 0.0);

      container.dispose();
    });
  });
}
