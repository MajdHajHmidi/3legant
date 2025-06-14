import 'package:json_annotation/json_annotation.dart';

part 'shop_data_model.g.dart';

@JsonSerializable()
class ShopDataModel {
  @JsonKey(name: "metadata")
  final Metadata metadata;
  @JsonKey(name: 'currency_code')
  final String currencyCode;
  @JsonKey(name: "categories")
  final List<Category> categories;
  @JsonKey(name: "total_price_range")
  final PriceRange totalPriceRange;

  ShopDataModel({
    required this.metadata,
    required this.currencyCode,
    required this.categories,
    required this.totalPriceRange,
  });

  factory ShopDataModel.fromJson(Map<String, dynamic> json) =>
      _$ShopDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopDataModelToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "discount")
  final double? discount;
  @JsonKey(name: "discount_end_date")
  final DateTime? discountEndDate;
  @JsonKey(name: "price_range")
  final PriceRange priceRange;

  Category({
    required this.id,
    required this.name,
    required this.discount,
    required this.discountEndDate,
    required this.priceRange,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class PriceRange {
  @JsonKey(name: "min_price")
  final double minPrice;
  @JsonKey(name: "max_price")
  final double maxPrice;

  PriceRange({required this.minPrice, required this.maxPrice});

  factory PriceRange.fromJson(Map<String, dynamic> json) =>
      _$PriceRangeFromJson(json);

  Map<String, dynamic> toJson() => _$PriceRangeToJson(this);
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "shop_page_title")
  final String shopPageTitle;
  @JsonKey(name: "shop_page_subtitle")
  final String shopPageSubtitle;
  @JsonKey(name: "shop_page_thumbnail_url")
  final String shopPageThumbnailUrl;

  Metadata({
    required this.shopPageTitle,
    required this.shopPageSubtitle,
    required this.shopPageThumbnailUrl,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
