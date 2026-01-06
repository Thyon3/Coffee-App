import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffe_app_ui/application/providers/cart_providers.dart';
import 'package:coffe_app_ui/data/storage/orders_storage.dart';
import 'package:coffe_app_ui/domain/entities/order.dart';
import 'package:coffe_app_ui/domain/entities/order_status.dart';

final ordersStorageProvider = Provider<OrdersStorage>((ref) => SharedPrefsOrdersStorage());

class OrdersNotifier extends StateNotifier<List<Order>> {
  OrdersNotifier(this._storage) : super(const []) {
    _init();
  }
  final OrdersStorage _storage;
  Timer? _timer;

  Future<void> _init() async {
    final data = await _storage.load();
    state = data;
  }

  Future<Order> createOrder(List<Order> previous, double total, List items) async {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      items: items.cast(),
      total: total,
      status: OrderStatus.pending,
    );
    state = [...state, order];
    await _storage.save(state);
    return order;
  }

  // Simulate async status updates: pending -> preparing -> ready -> completed
  void simulateStatusUpdates(String orderId) {
    Order? getOrder() => state.firstWhere((o) => o.id == orderId, orElse: () => null as Order);
    void update(OrderStatus s) async {
      final idx = state.indexWhere((o) => o.id == orderId);
      if (idx == -1) return;
      final updated = state[idx].copyWith(status: s);
      state = [...state]..[idx] = updated;
      await _storage.save(state);
    }

    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), () {
      update(OrderStatus.preparing);
      _timer = Timer(const Duration(seconds: 2), () {
        update(OrderStatus.ready);
        _timer = Timer(const Duration(seconds: 2), () {
          update(OrderStatus.completed);
        });
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<Order>>((ref) {
  final storage = ref.watch(ordersStorageProvider);
  return OrdersNotifier(storage);
});

// Ready provider for applying AsyncLoader/Error in UI without changing orders state shape
final ordersReadyProvider = FutureProvider<void>((ref) async {
  final storage = ref.read(ordersStorageProvider);
  await storage.load();
});
