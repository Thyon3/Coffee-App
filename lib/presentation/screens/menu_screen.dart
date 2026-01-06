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

    final isGrid = ref.watch(isGridLayoutProvider.select((v) => v));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        actions: [
          IconButton(
            tooltip: isGrid ? 'Switch to list' : 'Switch to grid',
            icon: Icon(isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () => ref.read(isGridLayoutProvider.notifier).state = !isGrid,
          ),
        ],
      ),
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
              data: (items) => isGrid
                  ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.75,
                      ),
                      padding: const EdgeInsets.all(12),
                      itemCount: items.length,
                      itemBuilder: (context, index) => FadeIn(delayMs: (index % 8) * 40, child: DrinkCard(drink: items[index], isGrid: true)), 
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemBuilder: (context, index) => FadeIn(delayMs: (index % 8) * 40, child: DrinkCard(drink: items[index], isGrid: false)), 
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemCount: items.length,
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
