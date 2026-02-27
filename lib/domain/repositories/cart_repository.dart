import 'package:coffe_app_ui/domain/entities/cart.dart';
import 'package:coffe_app_ui/domain/entities/cart_item.dart';

abstract class CartRepository {
  /// Get the current cart
  Future<Cart> getCart();
  
  /// Save the cart
  Future<void> saveCart(Cart cart);
  
  /// Add an item to the cart
  Future<Cart> addItem(CartItem item);
  
  /// Remove an item from the cart
  Future<Cart> removeItem(String itemId);
  
  /// Update item quantity
  Future<Cart> updateItemQuantity(String itemId, int quantity);
  
  /// Clear the cart
  Future<void> clearCart();
}
