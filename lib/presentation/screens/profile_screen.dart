import 'package:coffe_app_ui/application/providers/user_prefs_providers.dart';
import 'package:coffe_app_ui/application/providers/menu_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(userPrefsProvider);
    final categoriesAsync = ref.watch(menuCategoriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: prefsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (prefs) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              title: const Text('Dark mode'),
              value: prefs.darkMode,
              onChanged: (v) => ref.read(userPrefsProvider.notifier).updateDarkMode(v),
            ),
            SwitchListTile(
              title: const Text('Reduce motion'),
              value: prefs.reduceMotion,
              onChanged: (v) => ref.read(userPrefsProvider.notifier).updateReduceMotion(v),
            ),
            const SizedBox(height: 16),
            const Text('Favorite category', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            categoriesAsync.when(
              data: (cats) => Wrap(
                spacing: 8,
                children: [
                  for (final c in cats)
                    ChoiceChip(
                      label: Text(c.name),
                      selected: c.id == prefs.favoriteCategoryId,
                      onSelected: (_) => ref.read(userPrefsProvider.notifier).updateFavoriteCategory(c.id),
                    ),
                ],
              ),
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('Failed to load categories: $e'),
            ),
            const SizedBox(height: 24),
            const Text('Stats', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _StatTile(label: 'Favorites saved', valueProvider: null),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.valueProvider});
  final String label;
  final Object? valueProvider; // Placeholder for future stats providers

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: const Text('—'),
    );
  }
}
