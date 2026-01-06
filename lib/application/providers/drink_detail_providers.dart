import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffe_app_ui/application/state/drink_detail_state.dart';
import 'package:coffe_app_ui/domain/entities/drink.dart';
import 'package:coffe_app_ui/domain/value_objects/extra.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';

// Available extras for a drink (mocked per type for now)
final drinkExtrasProvider = Provider.family<List<Extra>, Drink>((ref, drink) {
  // You can vary extras by drink type/name if needed
  return const [
    Extra(id: 'extra_shot', name: 'Extra Shot', price: Price(amount: 0.80)),
    Extra(id: 'oat_milk', name: 'Oat Milk', price: Price(amount: 0.50)),
    Extra(id: 'whipped', name: 'Whipped Cream', price: Price(amount: 0.40)),
  ];
});

// State notifier for drink detail (autoDispose to reset on navigation exit)
class DrinkDetailNotifier extends StateNotifier<DrinkDetailState> {
  DrinkDetailNotifier({required Drink drink})
      : super(DrinkDetailState(drink: drink, selectedSize: drink.availableSizes.first));

  void selectSize(DrinkSize size) => state = state.copyWith(selectedSize: size);

  void toggleExtra(String extraId) {
    final set = Set<String>.from(state.selectedExtraIds);
    if (set.contains(extraId)) {
      set.remove(extraId);
    } else {
      set.add(extraId);
    }
    state = state.copyWith(selectedExtraIds: set);
  }
}

final drinkDetailProvider = StateNotifierProvider.autoDispose.family<DrinkDetailNotifier, DrinkDetailState, Drink>((ref, drink) {
  return DrinkDetailNotifier(drink: drink);
});

// Reactive computed price that sums extras
final drinkTotalPriceProvider = Provider.autoDispose.family<double, Drink>((ref, drink) {
  final state = ref.watch(drinkDetailProvider(drink));
  final extras = ref.watch(drinkExtrasProvider(drink));
  final base = state.drink.basePrice.amount;
  final sizeFactor = switch (state.selectedSize.type) {
    DrinkSizeType.small => 1.0,
    DrinkSizeType.medium => 1.2,
    DrinkSizeType.large => 1.4,
  };
  final extrasMap = {for (final e in extras) e.id: e};
  final extrasTotal = state.selectedExtraIds.fold<double>(0.0, (sum, id) => sum + (extrasMap[id]?.price.amount ?? 0.0));
  return (base * sizeFactor) + extrasTotal;
});
