import 'package:coffe_app_ui/application/providers/coffee_providers.dart';
import 'package:coffe_app_ui/presentation/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final selectedIndex = ref.watch(selectedCategoryProvider);
    final coffeesAsync = ref.watch(filteredCoffeeListProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 17, 17, 17),
                          Color.fromARGB(255, 49, 49, 49),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        Row(
                          children: [
                            Text(
                              'Addis Ababa, Ethiopia',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 25,
                              color: Colors.amber,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.sizeOf(context).height * 0.09,
                    left: MediaQuery.sizeOf(context).width * 0.09,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 110, 108, 98),
                            Color.fromARGB(255, 44, 44, 44),
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 40,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                suffixIcon: const Icon(
                                  Icons.coffee,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                hintText: 'Search Your coffee...',
                                hintStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.sizeOf(context).height * 0.177,
                    left: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/download (1).jpg',
                        height: MediaQuery.sizeOf(context).height * 0.2,
                        width: MediaQuery.sizeOf(context).width * 0.7,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.12),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.030,
                child: categoriesAsync.when(
                  data: (categories) => ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final isSelected = selectedIndex == index;
                      return InkWell(
                        onTap: () => ref.read(selectedCategoryProvider.notifier).state = index,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color.fromARGB(255, 255, 191, 0)
                                : const Color.fromARGB(255, 231, 222, 222),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 15),
              coffeesAsync.when(
                data: (coffees) => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: MediaQuery.sizeOf(context).height * 0.35,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: coffees.length,
                  itemBuilder: (context, index) {
                    final coffee = coffees[index];
                    return GestureDetector(
                      onTap: () => context.go(AppRoutes.details, extra: coffee),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadiusDirectional.all(Radius.circular(8)),
                              child: Column(
                                children: [
                                  Image.network(
                                    coffee.image,
                                    fit: BoxFit.cover,
                                    height: MediaQuery.sizeOf(context).height * 0.17,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.surface,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          coffee.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.lato(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Text(
                                          coffee.type,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.buda(
                                            fontSize: 16,
                                            height: 1,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text(
                                              '\$${coffee.price}',
                                              style: GoogleFonts.buda(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w900,
                                                height: 1,
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {},
                                              borderRadius: BorderRadius.circular(6),
                                              child: Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6),
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
