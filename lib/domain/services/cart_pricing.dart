import 'package:coffe_app_ui/domain/entities/cart_item.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';

class CartPricingService {
  const CartPricingService();

  double unitPrice(CartItem item) {
    final sizeFactor = switch (item.size.type) {
      DrinkSizeType.small => 1.0,
      DrinkSizeType.medium => 1.2,
      DrinkSizeType.large => 1.4,
    };
    final extrasTotal = item.extras.fold<double>(0.0, (sum, e) => sum + e.price.amount);
    return (item.basePrice * sizeFactor) + extrasTotal;
  }

  double lineTotal(CartItem item) => unitPrice(item) * item.quantity;

  double cartTotal(Iterable<CartItem> items) => items.fold(0.0, (sum, it) => sum + lineTotal(it));
}
