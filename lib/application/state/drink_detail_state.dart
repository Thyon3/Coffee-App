import 'package:equatable/equatable.dart';
import 'package:coffe_app_ui/domain/entities/drink.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';
import 'package:coffe_app_ui/domain/value_objects/extra.dart';
import 'package:coffe_app_ui/domain/value_objects/price.dart';

class DrinkDetailState extends Equatable {
  final Drink drink;
  final DrinkSize selectedSize;
  final Set<String> selectedExtraIds;

  const DrinkDetailState({
    required this.drink,
    required this.selectedSize,
    this.selectedExtraIds = const {},
  });

  Price get totalPrice {
    final base = drink.basePrice.amount;
    // simple size-based multiplier example
    final sizeFactor = switch (selectedSize.type) {
      DrinkSizeType.small => 1.0,
      DrinkSizeType.medium => 1.2,
      DrinkSizeType.large => 1.4,
    };
    final extrasTotal = 0.0; // extras will be summed in provider using available extras
    return Price(amount: (base * sizeFactor) + extrasTotal, currency: drink.basePrice.currency);
  }

  DrinkDetailState copyWith({DrinkSize? selectedSize, Set<String>? selectedExtraIds}) => DrinkDetailState(
        drink: drink,
        selectedSize: selectedSize ?? this.selectedSize,
        selectedExtraIds: selectedExtraIds ?? this.selectedExtraIds,
      );

  @override
  List<Object?> get props => [drink, selectedSize, selectedExtraIds];
}
