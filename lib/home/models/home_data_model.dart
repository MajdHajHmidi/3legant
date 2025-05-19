import 'package:json_annotation/json_annotation.dart';

part 'home_data_model.g.dart';

@JsonSerializable()
class HomeDataModel {
  @JsonKey(name: "metadata")
  final Metadata metadata;
  @JsonKey(name: "popular_categories")
  final List<PopularCategory> popularCategories;
  @JsonKey(name: "new_products")
  final NewProducts newProducts;
  @JsonKey(name: "popular_blogs")
  final PopularBlogs popularBlogs;

  HomeDataModel({
    required this.metadata,
    required this.popularCategories,
    required this.newProducts,
    required this.popularBlogs,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$HomeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataModelToJson(this);
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "thumbnail_url1")
  final String thumbnailUrl1;
  @JsonKey(name: "thumbnail_url2")
  final String thumbnailUrl2;
  @JsonKey(name: "thumbnail_url3")
  final String thumbnailUrl3;
  @JsonKey(name: "descriptive_title1")
  final String descriptiveTitle1;
  @JsonKey(name: "descriptive_title2")
  final String descriptiveTitle2;
  @JsonKey(name: "app_name")
  final String appName;
  @JsonKey(name: "app_description")
  final String appDescription;
  @JsonKey(name: "app_feature_1_title")
  final String appFeature1Title;
  @JsonKey(name: "app_feature_2_title")
  final String appFeature2Title;
  @JsonKey(name: "app_feature_3_title")
  final String appFeature3Title;
  @JsonKey(name: "app_feature_4_title")
  final String appFeature4Title;
  @JsonKey(name: "app_feature_1_message")
  final String appFeature1Message;
  @JsonKey(name: "app_feature_2_message")
  final String appFeature2Message;
  @JsonKey(name: "app_feature_3_message")
  final String appFeature3Message;
  @JsonKey(name: "app_feature_4_message")
  final String appFeature4Message;
  @JsonKey(name: "discount_banner_sales_info")
  final String discountBannerSalesInfo;
  @JsonKey(name: "discount_banner_title")
  final String discountBannerTitle;
  @JsonKey(name: "discount_banner_subtitle")
  final String discountBannerSubtitle;
  @JsonKey(name: "discount_banner_image_url")
  final String discountBannerImageUrl;

  Metadata({
    required this.thumbnailUrl1,
    required this.thumbnailUrl2,
    required this.thumbnailUrl3,
    required this.descriptiveTitle1,
    required this.descriptiveTitle2,
    required this.appName,
    required this.appDescription,
    required this.appFeature1Title,
    required this.appFeature2Title,
    required this.appFeature3Title,
    required this.appFeature4Title,
    required this.appFeature1Message,
    required this.appFeature2Message,
    required this.appFeature3Message,
    required this.appFeature4Message,
    required this.discountBannerSalesInfo,
    required this.discountBannerTitle,
    required this.discountBannerSubtitle,
    required this.discountBannerImageUrl,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable()
class NewProducts {
  @JsonKey(name: "products")
  final List<Product> products;

  NewProducts({required this.products});

  factory NewProducts.fromJson(Map<String, dynamic> json) =>
      _$NewProductsFromJson(json);

  Map<String, dynamic> toJson() => _$NewProductsToJson(this);
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
  final CurrencyCode currencyCode;
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

enum CurrencyCode {
  @JsonValue("USD")
  // ignore: constant_identifier_names
  USD,
}

@JsonSerializable()
class PopularBlogs {
  @JsonKey(name: "blogs")
  final List<Blog> blogs;

  PopularBlogs({required this.blogs});

  factory PopularBlogs.fromJson(Map<String, dynamic> json) =>
      _$PopularBlogsFromJson(json);

  Map<String, dynamic> toJson() => _$PopularBlogsToJson(this);
}

@JsonSerializable()
class Blog {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "category_id")
  final String categoryId;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "publisher")
  final String publisher;
  @JsonKey(name: "thumbnail_url")
  final String thumbnailUrl;
  @JsonKey(name: "introduction")
  final String introduction;

  Blog({
    required this.id,
    required this.categoryId,
    required this.createdAt,
    required this.title,
    required this.publisher,
    required this.thumbnailUrl,
    required this.introduction,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => _$BlogFromJson(json);

  Map<String, dynamic> toJson() => _$BlogToJson(this);
}

@JsonSerializable()
class PopularCategory {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "discount")
  final int? discount;
  @JsonKey(name: "discount_end_date")
  final DateTime? discountEndDate;
  @JsonKey(name: "image_url")
  final String imageUrl;

  PopularCategory({
    required this.id,
    required this.name,
    required this.discount,
    required this.discountEndDate,
    required this.imageUrl,
  });

  factory PopularCategory.fromJson(Map<String, dynamic> json) =>
      _$PopularCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$PopularCategoryToJson(this);
}
