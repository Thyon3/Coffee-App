import 'package:equatable/equatable.dart';
import 'package:coffe_app_ui/domain/entities/cart_item.dart';
import 'package:coffe_app_ui/domain/entities/order_status.dart';

class Order extends Equatable {
  final String id;
  final DateTime createdAt;
  final List<CartItem> items; // snapshot of cart at order time
  final double total;
  final OrderStatus status;

  const Order({
    required this.id,
    required this.createdAt,
    required this.items,
    required this.total,
    required this.status,
  });

  Order copyWith({OrderStatus? status}) => Order(
        id: id,
        createdAt: createdAt,
        items: items,
        total: total,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [id, createdAt, items, total, status];
}
