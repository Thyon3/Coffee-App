import 'package:coffe_app_ui/application/providers/menu_providers.dart';
import 'package:coffe_app_ui/presentation/widgets/drink_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCat = ref.watch(selectedCategoryIdProvider.select((s) => s));
    final categoriesAsync = ref.watch(menuCategoriesProvider);
    final drinksAsync = ref.watch(filteredDrinksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: categoriesAsync.when(
              data: (cats) => ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  final c = cats[index];
                  final isSelected = c.id == selectedCat;
                  return FilterChip(
                    label: Text(c.name),
                    selected: isSelected,
                    onSelected: (_) => ref.read(selectedCategoryIdProvider.notifier).state = c.id,
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: cats.length,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: drinksAsync.when(
              data: (items) => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                padding: const EdgeInsets.all(12),
                itemCount: items.length,
                itemBuilder: (context, index) => DrinkCard(drink: items[index]),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
