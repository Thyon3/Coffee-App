import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffe_app_ui/domain/entities/coffee_entity.dart';
import 'package:coffe_app_ui/domain/entities/search_filter.dart';
import 'package:coffe_app_ui/domain/repositories/coffee_repository.dart';
import 'package:coffe_app_ui/data/repositories/coffee_repository_impl.dart';
import 'package:coffe_app_ui/data/datasources/coffee_local_datasource.dart';

// Repository provider
final coffeeRepositoryProvider = Provider<CoffeeRepository>((ref) {
  return CoffeeRepositoryImpl(CoffeeLocalDataSource());
});

// Search state
class SearchState {
  final List<CoffeeEntity> results;
  final List<String> categories;
  final SearchFilter filter;
  final bool isLoading;
  final String? error;

  const SearchState({
    this.results = const [],
    this.categories = const [],
    this.filter = const SearchFilter(),
    this.isLoading = false,
    this.error,
  });

  SearchState copyWith({
    List<CoffeeEntity>? results,
    List<String>? categories,
    SearchFilter? filter,
    bool? isLoading,
    String? error,
  }) {
    return SearchState(
      results: results ?? this.results,
      categories: categories ?? this.categories,
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SearchState &&
        other.results == results &&
        other.categories == categories &&
        other.filter == filter &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode => results.hashCode ^ categories.hashCode ^ filter.hashCode ^ isLoading.hashCode ^ error.hashCode;
}

// Search notifier
class SearchNotifier extends StateNotifier<SearchState> {
  final CoffeeRepository _repository;

  SearchNotifier(this._repository) : super(const SearchState()) {
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _repository.getCategories();
      state = state.copyWith(categories: categories);
    } catch (e) {
      state = state.copyWith(error: 'Failed to load categories: ${e.toString()}');
    }
  }

  Future<void> searchCoffees(SearchFilter filter) async {
    state = state.copyWith(isLoading: true, error: null, filter: filter);
    
    try {
      final results = await _repository.searchCoffees(filter);
      state = state.copyWith(
        results: results,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to search: ${e.toString()}',
      );
    }
  }

  void updateQuery(String query) {
    final updatedFilter = state.filter.copyWith(query: query);
    searchCoffees(updatedFilter);
  }

  void updateCategories(List<String> categories) {
    final updatedFilter = state.filter.copyWith(categories: categories);
    searchCoffees(updatedFilter);
  }

  void updatePriceRange(double? minPrice, double? maxPrice) {
    final updatedFilter = state.filter.copyWith(
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
    searchCoffees(updatedFilter);
  }

  void updateRating(double? minRating) {
    final updatedFilter = state.filter.copyWith(minRating: minRating);
    searchCoffees(updatedFilter);
  }

  void updateSort(String sortBy, bool ascending) {
    final updatedFilter = state.filter.copyWith(
      sortBy: sortBy,
      ascending: ascending,
    );
    searchCoffees(updatedFilter);
  }

  void clearFilters() {
    final clearedFilter = const SearchFilter();
    searchCoffees(clearedFilter);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider for search notifier
final searchNotifierProvider = StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  final repository = ref.watch(coffeeRepositoryProvider);
  return SearchNotifier(repository);
});

// Convenience providers
final searchResultsProvider = Provider<List<CoffeeEntity>>((ref) {
  return ref.watch(searchNotifierProvider).results;
});

final searchCategoriesProvider = Provider<List<String>>((ref) {
  return ref.watch(searchNotifierProvider).categories;
});

final searchFilterProvider = Provider<SearchFilter>((ref) {
  return ref.watch(searchNotifierProvider).filter;
});

final searchLoadingProvider = Provider<bool>((ref) {
  return ref.watch(searchNotifierProvider).isLoading;
});

final searchErrorProvider = Provider<String?>((ref) {
  return ref.watch(searchNotifierProvider).error;
});
