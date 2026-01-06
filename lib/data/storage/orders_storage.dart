import 'dart:convert';

import 'package:coffe_app_ui/domain/entities/cart_item.dart';
import 'package:coffe_app_ui/domain/entities/order.dart';
import 'package:coffe_app_ui/domain/entities/order_status.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';
import 'package:coffe_app_ui/domain/value_objects/extra.dart';
import 'package:coffe_app_ui/domain/value_objects/price.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrdersStorage {
  Future<List<Order>> load();
  Future<void> save(List<Order> orders);
}

class SharedPrefsOrdersStorage implements OrdersStorage {
  static const _key = 'orders_v1';

  @override
  Future<List<Order>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return list.map(_fromMap).toList();
  }

  @override
  Future<void> save(List<Order> orders) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(orders.map(_toMap).toList());
    await prefs.setString(_key, data);
  }

  Map<String, dynamic> _toMap(Order o) => {
        'id': o.id,
        'createdAt': o.createdAt.toIso8601String(),
        'total': o.total,
        'status': o.status.name,
        'items': o.items.map(_itemToMap).toList(),
      };

  Map<String, dynamic> _itemToMap(CartItem i) => {
        'id': i.id,
        'drinkId': i.drinkId,
        'drinkName': i.drinkName,
        'image': i.image,
        'basePrice': i.basePrice,
        'size': i.size.type.name,
        'sizeVolume': i.size.volumeMl,
        'extras': i.extras
            .map((e) => {
                  'id': e.id,
                  'name': e.name,
                  'price': e.price.amount,
                  'currency': e.price.currency,
                })
            .toList(),
        'quantity': i.quantity,
      };

  Order _fromMap(Map<String, dynamic> m) => Order(
        id: m['id'] as String,
        createdAt: DateTime.parse(m['createdAt'] as String),
        items: (m['items'] as List)
            .cast<Map<String, dynamic>>()
            .map(_itemFromMap)
            .toList(),
        total: (m['total'] as num).toDouble(),
        status: OrderStatus.values.firstWhere((e) => e.name == m['status'] as String),
      );

  CartItem _itemFromMap(Map<String, dynamic> m) {
    final extras = (m['extras'] as List)
        .cast<Map<String, dynamic>>()
        .map((e) => Extra(id: e['id'] as String, name: e['name'] as String, price: Price(amount: (e['price'] as num).toDouble(), currency: e['currency'] as String)))
        .toList();
    final sizeType = DrinkSizeType.values.firstWhere((t) => t.name == m['size'] as String);
    final size = DrinkSize(type: sizeType, volumeMl: (m['sizeVolume'] as num).toDouble());
    return CartItem(
      id: m['id'] as String,
      drinkId: m['drinkId'] as String,
      drinkName: m['drinkName'] as String,
      image: m['image'] as String,
      basePrice: (m['basePrice'] as num).toDouble(),
      size: size,
      extras: extras,
      quantity: m['quantity'] as int,
    );
  }
}
