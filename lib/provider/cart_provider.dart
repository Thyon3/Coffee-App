import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffe_app_ui/domain/entities/cart.dart';
import 'package:coffe_app_ui/domain/entities/cart_item.dart';
import 'package:coffe_app_ui/domain/repositories/cart_repository.dart';
import 'package:coffe_app_ui/data/repositories/cart_repository_impl.dart';

// Repository provider
final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepositoryImpl();
});

// Cart state
class CartState {
  final Cart cart;
  final bool isLoading;
  final String? error;

  const CartState({
    required this.cart,
    this.isLoading = false,
    this.error,
  });

  CartState copyWith({
    Cart? cart,
    bool? isLoading,
    String? error,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartState &&
        other.cart == cart &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode => cart.hashCode ^ isLoading.hashCode ^ error.hashCode;
}

// Cart notifier
class CartNotifier extends StateNotifier<CartState> {
  final CartRepository _repository;

  CartNotifier(this._repository) : super(const CartState(cart: Cart.empty()));

  /// Load the cart from storage
  Future<void> loadCart() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final cart = await _repository.getCart();
      state = state.copyWith(cart: cart, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load cart: ${e.toString()}',
      );
    }
  }

  /// Add an item to the cart
  Future<void> addItem(CartItem item) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updatedCart = await _repository.addItem(item);
      state = state.copyWith(cart: updatedCart, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to add item: ${e.toString()}',
      );
    }
  }

  /// Remove an item from the cart
  Future<void> removeItem(String itemId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updatedCart = await _repository.removeItem(itemId);
      state = state.copyWith(cart: updatedCart, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to remove item: ${e.toString()}',
      );
    }
  }

  /// Update item quantity
  Future<void> updateItemQuantity(String itemId, int quantity) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updatedCart = await _repository.updateItemQuantity(itemId, quantity);
      state = state.copyWith(cart: updatedCart, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to update quantity: ${e.toString()}',
      );
    }
  }

  /// Clear the entire cart
  Future<void> clearCart() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.clearCart();
      state = state.copyWith(cart: const Cart.empty(), isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to clear cart: ${e.toString()}',
      );
    }
  }

  /// Clear any error state
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider for the cart notifier
final cartNotifierProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return CartNotifier(repository);
});

// Convenience providers for common cart values
final cartProvider = Provider<Cart>((ref) {
  return ref.watch(cartNotifierProvider).cart;
});

final cartItemsProvider = Provider<List<CartItem>>((ref) {
  return ref.watch(cartProvider).items;
});

final cartTotalPriceProvider = Provider<double>((ref) {
  return ref.watch(cartProvider).totalPrice.amount;
});

final cartTotalItemsProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).totalItems;
});

final cartIsEmptyProvider = Provider<bool>((ref) {
  return ref.watch(cartProvider).isEmpty;
});

final cartIsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(cartNotifierProvider).isLoading;
});

final cartErrorProvider = Provider<String?>((ref) {
  return ref.watch(cartNotifierProvider).error;
});
