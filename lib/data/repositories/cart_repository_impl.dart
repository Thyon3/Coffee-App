import 'dart:convert';
import 'package:coffe_app_ui/domain/entities/cart.dart';
import 'package:coffe_app_ui/domain/entities/cart_item.dart';
import 'package:coffe_app_ui/domain/repositories/cart_repository.dart';
import 'package:coffe_app_ui/data/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepositoryImpl implements CartRepository {
  static const String _cartKey = 'cart_data';
  
  @override
  Future<Cart> getCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString(_cartKey);
      
      if (cartJson == null) {
        return const Cart.empty();
      }
      
      final cartModel = CartModel.fromJson(jsonDecode(cartJson));
      return cartModel.toEntity();
    } catch (e) {
      // Return empty cart if there's an error
      return const Cart.empty();
    }
  }
  
  @override
  Future<void> saveCart(Cart cart) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartModel = CartModel.fromEntity(cart);
      await prefs.setString(_cartKey, jsonEncode(cartModel.toJson()));
    } catch (e) {
      // Handle error silently for now
      rethrow;
    }
  }
  
  @override
  Future<Cart> addItem(CartItem item) async {
    final currentCart = await getCart();
    final updatedCart = currentCart.addItem(item);
    await saveCart(updatedCart);
    return updatedCart;
  }
  
  @override
  Future<Cart> removeItem(String itemId) async {
    final currentCart = await getCart();
    final updatedCart = currentCart.removeItem(itemId);
    await saveCart(updatedCart);
    return updatedCart;
  }
  
  @override
  Future<Cart> updateItemQuantity(String itemId, int quantity) async {
    final currentCart = await getCart();
    final updatedCart = currentCart.updateItemQuantity(itemId, quantity);
    await saveCart(updatedCart);
    return updatedCart;
  }
  
  @override
  Future<void> clearCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cartKey);
    } catch (e) {
      rethrow;
    }
  }
}
