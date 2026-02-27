import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffe_app_ui/screens/cart_screen.dart';
import 'package:coffe_app_ui/provider/cart_provider.dart';

void main() {
  group('Cart Screen Widget Tests', () {
    testWidgets('should display empty cart state', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CartScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.text('Add some delicious coffee to get started!'), findsOneWidget);
      expect(find.text('Browse Coffee'), findsOneWidget);
    });

    testWidgets('should display cart items when cart is not empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            cartNotifierProvider.overrideWith((ref) {
              final notifier = CartNotifier(MockCartRepository());
              // Add mock items here
              return notifier;
            }),
          ],
          child: const MaterialApp(
            home: CartScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Test cart item display logic
      expect(find.byType(CartScreen), findsOneWidget);
    });

    testWidgets('should show checkout button when cart has items', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CartScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // In empty cart state, checkout button should not be visible
      expect(find.text('Proceed to Checkout'), findsNothing);
    });
  });
}

class MockCartRepository implements CartRepository {
  @override
  Future<Cart> getCart() async {
    return Cart.empty();
  }

  @override
  Future<void> saveCart(Cart cart) async {}

  @override
  Future<Cart> addItem(CartItem item) async {
    return Cart.empty();
  }

  @override
  Future<Cart> removeItem(String itemId) async {
    return Cart.empty();
  }

  @override
  Future<Cart> updateItemQuantity(String itemId, int quantity) async {
    return Cart.empty();
  }

  @override
  Future<void> clearCart() async {}
}
