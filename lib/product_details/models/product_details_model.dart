import 'package:json_annotation/json_annotation.dart';

part 'product_details_model.g.dart';

@JsonSerializable()
class ProductDetailsModel {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "new")
  final bool isNew;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "price")
  final double price;
  @JsonKey(name: "colors")
  final List<Color> colors;
  @JsonKey(name: "rating")
  final double rating;
  @JsonKey(name: "details")
  final String details;
  @JsonKey(name: "similar_products")
  final List<ProductDetailsModel>? similarProducts;
  @JsonKey(name: "category")
  final String category;
  @JsonKey(name: "discount")
  final double? discount;
  @JsonKey(name: "favorite")
  final bool isFavorite;
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
  @JsonKey(name: "ratings_count")
  final int? ratingsCount;
  @JsonKey(name: "reviews_count")
  final int? reviewsCount;
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

  ProductDetailsModel({
    required this.id,
    required this.isNew,
    required this.name,
    required this.price,
    required this.colors,
    required this.rating,
    required this.details,
    this.similarProducts,
    required this.category,
    required this.discount,
    required this.isFavorite,
    required this.createdAt,
    required this.imagesUrl,
    required this.description,
    required this.measurements,
    required this.currencyCode,
    this.ratingsCount,
    this.reviewsCount,
    required this.packagingCount,
    required this.packagingWidth,
    required this.packagingHeight,
    required this.packagingLength,
    required this.packagingWeight,
    required this.discountEndDate,
    required this.productCategoryId,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsModelToJson(this);

  ProductDetailsModel copyWithRatings({int? ratingsCount, int? reviewsCount}) {
    return ProductDetailsModel(
      id: id,
      isNew: isNew,
      name: name,
      price: price,
      colors: colors,
      rating: rating,
      details: details,
      similarProducts: similarProducts,
      category: category,
      discount: discount,
      isFavorite: isFavorite,
      createdAt: createdAt,
      imagesUrl: imagesUrl,
      description: description,
      measurements: measurements,
      currencyCode: currencyCode,
      ratingsCount: ratingsCount ?? this.ratingsCount,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      packagingCount: packagingCount,
      packagingWidth: packagingWidth,
      packagingHeight: packagingHeight,
      packagingLength: packagingLength,
      packagingWeight: packagingWeight,
      discountEndDate: discountEndDate,
      productCategoryId: productCategoryId,
    );
  }
}

@JsonSerializable()
class Color {
  @JsonKey(name: "hex")
  final String hex;
  @JsonKey(name: "name")
  final String name;

  Color({required this.hex, required this.name});

  factory Color.fromJson(Map<String, dynamic> json) => _$ColorFromJson(json);

  Map<String, dynamic> toJson() => _$ColorToJson(this);
}
