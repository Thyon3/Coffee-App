import 'package:coffe_app_ui/application/providers/order_providers.dart';
import 'package:coffe_app_ui/domain/entities/order_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderHistoryScreen extends ConsumerWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: orders.isEmpty
          ? const Center(child: Text('No orders yet'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final o = orders[index];
                return ListTile(
                  title: Text('Order #${o.id}'),
                  subtitle: Text('${o.items.length} items • $${o.total.toStringAsFixed(2)}'),
                  trailing: _statusChip(o.status),
                );
              },
            ),
    );
  }

  Widget _statusChip(OrderStatus status) {
    final (label, color) = switch (status) {
      OrderStatus.pending => ('Pending', Colors.orange),
      OrderStatus.preparing => ('Preparing', Colors.blue),
      OrderStatus.ready => ('Ready', Colors.green),
      OrderStatus.completed => ('Completed', Colors.grey),
      OrderStatus.cancelled => ('Cancelled', Colors.red),
    };
    return Chip(label: Text(label), backgroundColor: color.withOpacity(0.1));
  }
}
