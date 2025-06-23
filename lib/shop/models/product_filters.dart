import '../../core/constants/app_constants.dart';

class ProductFilters {
  final String categoryId;
  final double? minPrice;
  final double? maxPrice;
  final String query;
  final int page;

  const ProductFilters({
    required this.categoryId,
    required this.minPrice,
    required this.maxPrice,
    this.query = '',
    this.page = AppConstants.appStartingPaginationIndex,
  });

  ProductFilters.empty()
    : categoryId = '',
      minPrice = null,
      maxPrice = null,
      query = '',
      page = AppConstants.appStartingPaginationIndex;

  ProductFilters copyWith({
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    String? query,
    int? page,
  }) {
    return ProductFilters(
      categoryId: categoryId ?? this.categoryId,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      query: query ?? this.query,
      page: page ?? this.page,
    );
  }

  @override
  bool operator ==(covariant ProductFilters other) {
    if (identical(this, other)) return true;

    return other.categoryId == categoryId &&
        other.minPrice == minPrice &&
        other.maxPrice == maxPrice &&
        other.query == query;
  }

  @override
  int get hashCode {
    return categoryId.hashCode ^
        minPrice.hashCode ^
        maxPrice.hashCode ^
        query.hashCode;
  }
}
