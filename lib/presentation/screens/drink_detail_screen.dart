import 'package:coffe_app_ui/application/providers/drink_detail_providers.dart';
import 'package:coffe_app_ui/domain/entities/drink.dart';
import 'package:coffe_app_ui/domain/value_objects/drink_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrinkDetailScreen extends ConsumerWidget {
  const DrinkDetailScreen({super.key, required this.drink});
  final Drink drink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(drinkDetailProvider(drink));
    final extras = ref.watch(drinkExtrasProvider(drink));
    final total = ref.watch(drinkTotalPriceProvider(drink));

    return Scaffold(
      appBar: AppBar(title: Text(drink.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Semantics(label: 'Image of ${drink.name}', child: _image(drink.image)), 
          ),
          const SizedBox(height: 16),
          Text(drink.description, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 24),
          const Text('Size', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8,
            children: [
              for (final s in drink.availableSizes)
                Tooltip(
                  message: 'Select size ${_labelForSize(s.type)}',
                  child: Semantics(
                    button: true,
                    label: 'Select size ${_labelForSize(s.type)}',
                    child: ChoiceChip(
                      label: Text(_labelForSize(s.type)),
                      selected: state.selectedSize.type == s.type,
                      onSelected: (_) => ref.read(drinkDetailProvider(drink).notifier).selectSize(s),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Extras', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8,
            children: [
              for (final e in extras)
                FilterChip(
                  label: Text("${e.name} (+\\$${e.price.amount.toStringAsFixed(2)})"),
                  selected: state.selectedExtraIds.contains(e.id),
                  onSelected: (_) => ref.read(drinkDetailProvider(drink).notifier).toggleExtra(e.id),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: \\$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Add to cart'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _labelForSize(DrinkSizeType type) => switch (type) {
        DrinkSizeType.small => 'S',
        DrinkSizeType.medium => 'M',
        DrinkSizeType.large => 'L',
      };

  Widget _image(String src) {
    if (src.startsWith('assets/')) return Image.asset(src, height: 200, fit: BoxFit.cover);
    if (src.startsWith('data:image')) return Container(height: 200, color: Colors.grey.shade300);
    return Image.network(src, height: 200, fit: BoxFit.cover);
  }
}
