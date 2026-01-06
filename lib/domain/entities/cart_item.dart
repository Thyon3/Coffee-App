import 'package:equatable/equatable.dart';
import 'package:coffe_app_ui/domain/entities/drink.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';
import 'package:coffe_app_ui/domain/value_objects/extra.dart';

class CartItem extends Equatable {
  final String id; // unique id per line (drinkId+size+extras hash)
  final String drinkId;
  final String drinkName;
  final String image;
  final double basePrice; // snapshot for consistency
  final DrinkSize size;
  final List<Extra> extras; // snapshot of selected extras
  final int quantity;

  const CartItem({
    required this.id,
    required this.drinkId,
    required this.drinkName,
    required this.image,
    required this.basePrice,
    required this.size,
    required this.extras,
    required this.quantity,
  });

  CartItem copyWith({int? quantity}) => CartItem(
        id: id,
        drinkId: drinkId,
        drinkName: drinkName,
        image: image,
        basePrice: basePrice,
        size: size,
        extras: extras,
        quantity: quantity ?? this.quantity,
      );

  @override
  List<Object?> get props => [id, drinkId, drinkName, image, basePrice, size, extras, quantity];

  static CartItem fromSelection({
    required Drink drink,
    required DrinkSize size,
    required List<Extra> extras,
    int quantity = 1,
  }) {
    final id = _composeId(drink.id, size, extras);
    return CartItem(
      id: id,
      drinkId: drink.id,
      drinkName: drink.name,
      image: drink.image,
      basePrice: drink.basePrice.amount,
      size: size,
      extras: extras,
      quantity: quantity,
    );
  }

  static String _composeId(String drinkId, DrinkSize size, List<Extra> extras) {
    final extrasKey = extras.map((e) => e.id).toList()..sort();
    return [drinkId, size.type.name, ...extrasKey].join('-');
  }
}
