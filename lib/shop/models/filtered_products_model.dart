import 'package:json_annotation/json_annotation.dart';

part 'filtered_products_model.g.dart';

@JsonSerializable()
class FilteredProductsModel {
  @JsonKey(name: "products")
  final List<Product> products;
  @JsonKey(name: "pagination_info")
  final PaginationInfo paginationInfo;

  FilteredProductsModel({required this.products, required this.paginationInfo});

  factory FilteredProductsModel.fromJson(Map<String, dynamic> json) =>
      _$FilteredProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilteredProductsModelToJson(this);
}

@JsonSerializable()
class PaginationInfo {
  @JsonKey(name: "current_page")
  final int currentPage;
  @JsonKey(name: "page_size")
  final int pageSize;
  @JsonKey(name: "total_items")
  final int totalItems;
  @JsonKey(name: "total_pages")
  final int totalPages;

  PaginationInfo({
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationInfoToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "new")
  final bool productNew;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "price")
  final double price;
  @JsonKey(name: "colors")
  final List<String> colors;
  @JsonKey(name: "rating")
  final double rating;
  @JsonKey(name: "details")
  final String details;
  @JsonKey(name: "category")
  final String category;
  @JsonKey(name: "discount")
  final int? discount;
  @JsonKey(name: "favorite")
  final bool favorite;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "images_url")
  final List<String> imagesUrl;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "measurements")
  final String measurements;
  @JsonKey(name: "currency_code")
  final String currencyCode;
  @JsonKey(name: "packaging_count")
  final int packagingCount;
  @JsonKey(name: "packaging_width")
  final int packagingWidth;
  @JsonKey(name: "packaging_height")
  final double packagingHeight;
  @JsonKey(name: "packaging_length")
  final double packagingLength;
  @JsonKey(name: "packaging_weight")
  final String packagingWeight;
  @JsonKey(name: "discount_end_date")
  final DateTime? discountEndDate;
  @JsonKey(name: "product_category_id")
  final String productCategoryId;

  Product({
    required this.id,
    required this.productNew,
    required this.name,
    required this.price,
    required this.colors,
    required this.rating,
    required this.details,
    required this.category,
    required this.discount,
    required this.favorite,
    required this.createdAt,
    required this.imagesUrl,
    required this.description,
    required this.measurements,
    required this.currencyCode,
    required this.packagingCount,
    required this.packagingWidth,
    required this.packagingHeight,
    required this.packagingLength,
    required this.packagingWeight,
    required this.discountEndDate,
    required this.productCategoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
