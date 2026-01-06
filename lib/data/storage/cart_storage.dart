import 'dart:convert';

import 'package:coffe_app_ui/domain/entities/cart_item.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';
import 'package:coffe_app_ui/domain/value_objects/extra.dart';
import 'package:coffe_app_ui/domain/value_objects/price.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartStorage {
  Future<List<CartItem>> load();
  Future<void> save(List<CartItem> items);
}

class SharedPrefsCartStorage implements CartStorage {
  static const _key = 'cart_items_v1';

  @override
  Future<List<CartItem>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return list.map(_fromMap).toList();
  }

  @override
  Future<void> save(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(items.map(_toMap).toList());
    await prefs.setString(_key, data);
  }

  Map<String, dynamic> _toMap(CartItem i) => {
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

  CartItem _fromMap(Map<String, dynamic> m) {
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
