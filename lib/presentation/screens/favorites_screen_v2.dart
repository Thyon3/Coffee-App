import 'package:coffe_app_ui/application/providers/favorites_providers.dart';
import 'package:coffe_app_ui/application/providers/menu_providers.dart';
import 'package:coffe_app_ui/presentation/widgets/drink_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreenV2 extends ConsumerWidget {
  const FavoritesScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favs = ref.watch(favoritesProvider);
    final drinksAsync = ref.watch(allDrinksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: drinksAsync.when(
        data: (items) {
          final filtered = items.where((d) => favs.contains(d.id)).toList();
          if (filtered.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) => DrinkCard(drink: filtered[index], isGrid: false),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemCount: filtered.length,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const SizedBox.shrink(),
      ),
    );
  }
}
