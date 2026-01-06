import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffe_app_ui/data/storage/cart_storage.dart';
import 'package:coffe_app_ui/domain/entities/cart_item.dart';
import 'package:coffe_app_ui/domain/services/cart_pricing.dart';

final cartStorageProvider = Provider<CartStorage>((ref) => SharedPrefsCartStorage());
final cartPricingProvider = Provider<CartPricingService>((ref) => const CartPricingService());

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier(this._storage) : super(const []) {
    _init();
  }
  final CartStorage _storage;

  Future<void> _init() async {
    final items = await _storage.load();
    state = items;
  }

  // Unit-testable operations
  void addOrIncrease(CartItem item) {
    final idx = state.indexWhere((e) => e.id == item.id);
    if (idx == -1) {
      state = [...state, item];
    } else {
      final updated = state[idx].copyWith(quantity: state[idx].quantity + item.quantity);
      state = [...state]..[idx] = updated;
    }
    _persist();
  }

  void decreaseQuantity(String id) {
    final idx = state.indexWhere((e) => e.id == id);
    if (idx == -1) return;
    final current = state[idx];
    if (current.quantity <= 1) {
      remove(id);
    } else {
      final updated = current.copyWith(quantity: current.quantity - 1);
      state = [...state]..[idx] = updated;
      _persist();
    }
  }

  void increaseQuantity(String id) {
    final idx = state.indexWhere((e) => e.id == id);
    if (idx == -1) return;
    final updated = state[idx].copyWith(quantity: state[idx].quantity + 1);
    state = [...state]..[idx] = updated;
    _persist();
  }

  void remove(String id) {
    state = state.where((e) => e.id != id).toList();
    _persist();
  }

  void clear() {
    state = const [];
    _persist();
  }

  Future<void> _persist() => _storage.save(state);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  final storage = ref.watch(cartStorageProvider);
  return CartNotifier(storage);
});

final cartTotalProvider = Provider<double>((ref) {
  final items = ref.watch(cartProvider);
  final pricing = ref.watch(cartPricingProvider);
  return pricing.cartTotal(items);
});
