import 'package:coffe_app_ui/application/providers/navigation_providers.dart';
import 'package:coffe_app_ui/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  static const _destinations = <Widget>[
    HomeScreen(),
    Center(child: Text('favourites')),
    Center(child: Text('cart')),
    Center(child: Text('notifications')),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee App'),
        actions: [
          IconButton(
            tooltip: 'Profile',
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: _destinations[index],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.black, Color.fromARGB(139, 0, 0, 0)],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(4, (i) {
            final isActive = index == i;
            final icon = <IconData>[
              Icons.home,
              Icons.heart_broken_outlined,
              Icons.shopping_bag,
              Icons.notification_add,
            ][i];
            return Expanded(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.07,
                child: InkWell(
                  onTap: () => ref.read(bottomNavIndexProvider.notifier).state = i,
                  child: Column(
                    children: [
                      const SizedBox(height: 7),
                      Icon(
                        icon,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      if (isActive)
                        const Icon(
                          Icons.minimize,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 5,
                              color: Colors.white,
                              offset: Offset(3, 5),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
