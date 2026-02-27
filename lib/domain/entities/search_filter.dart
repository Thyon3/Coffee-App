import 'package:equatable/equatable.dart';
import 'package:coffe_app_ui/domain/entities/coffee_entity.dart';

class SearchFilter extends Equatable {
  final String query;
  final List<String> categories;
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;
  final String sortBy; // 'name', 'price', 'rating'
  final bool ascending;

  const SearchFilter({
    this.query = '',
    this.categories = const [],
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.sortBy = 'name',
    this.ascending = true,
  });

  SearchFilter copyWith({
    String? query,
    List<String>? categories,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    String? sortBy,
    bool? ascending,
  }) {
    return SearchFilter(
      query: query ?? this.query,
      categories: categories ?? this.categories,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
    );
  }

  bool get hasActiveFilter =>
      query.isNotEmpty ||
      categories.isNotEmpty ||
      minPrice != null ||
      maxPrice != null ||
      minRating != null;

  @override
  List<Object?> get props => [
        query,
        categories,
        minPrice,
        maxPrice,
        minRating,
        sortBy,
        ascending,
      ];
}
