// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDataModel _$HomeDataModelFromJson(Map<String, dynamic> json) =>
    HomeDataModel(
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      popularCategories:
          (json['popular_categories'] as List<dynamic>)
              .map((e) => PopularCategory.fromJson(e as Map<String, dynamic>))
              .toList(),
      newProducts: NewProducts.fromJson(
        json['new_products'] as Map<String, dynamic>,
      ),
      popularBlogs: PopularBlogs.fromJson(
        json['popular_blogs'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$HomeDataModelToJson(HomeDataModel instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'popular_categories': instance.popularCategories,
      'new_products': instance.newProducts,
      'popular_blogs': instance.popularBlogs,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
  thumbnailUrl1: json['thumbnail_url1'] as String,
  thumbnailUrl2: json['thumbnail_url2'] as String,
  thumbnailUrl3: json['thumbnail_url3'] as String,
  descriptiveTitle1: json['descriptive_title1'] as String,
  descriptiveTitle2: json['descriptive_title2'] as String,
  appName: json['app_name'] as String,
  appDescription: json['app_description'] as String,
  appFeature1Title: json['app_feature_1_title'] as String,
  appFeature2Title: json['app_feature_2_title'] as String,
  appFeature3Title: json['app_feature_3_title'] as String,
  appFeature4Title: json['app_feature_4_title'] as String,
  appFeature1Message: json['app_feature_1_message'] as String,
  appFeature2Message: json['app_feature_2_message'] as String,
  appFeature3Message: json['app_feature_3_message'] as String,
  appFeature4Message: json['app_feature_4_message'] as String,
  discountBannerSalesInfo: json['discount_banner_sales_info'] as String,
  discountBannerTitle: json['discount_banner_title'] as String,
  discountBannerSubtitle: json['discount_banner_subtitle'] as String,
  discountBannerImageUrl: json['discount_banner_image_url'] as String,
);

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
  'thumbnail_url1': instance.thumbnailUrl1,
  'thumbnail_url2': instance.thumbnailUrl2,
  'thumbnail_url3': instance.thumbnailUrl3,
  'descriptive_title1': instance.descriptiveTitle1,
  'descriptive_title2': instance.descriptiveTitle2,
  'app_name': instance.appName,
  'app_description': instance.appDescription,
  'app_feature_1_title': instance.appFeature1Title,
  'app_feature_2_title': instance.appFeature2Title,
  'app_feature_3_title': instance.appFeature3Title,
  'app_feature_4_title': instance.appFeature4Title,
  'app_feature_1_message': instance.appFeature1Message,
  'app_feature_2_message': instance.appFeature2Message,
  'app_feature_3_message': instance.appFeature3Message,
  'app_feature_4_message': instance.appFeature4Message,
  'discount_banner_sales_info': instance.discountBannerSalesInfo,
  'discount_banner_title': instance.discountBannerTitle,
  'discount_banner_subtitle': instance.discountBannerSubtitle,
  'discount_banner_image_url': instance.discountBannerImageUrl,
};

NewProducts _$NewProductsFromJson(Map<String, dynamic> json) => NewProducts(
  products:
      (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$NewProductsToJson(NewProducts instance) =>
    <String, dynamic>{'products': instance.products};

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['id'] as String,
  productNew: json['new'] as bool,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  colors:
      (json['colors'] as List<dynamic>)
          .map((e) => Color.fromJson(e as Map<String, dynamic>))
          .toList(),
  rating: (json['rating'] as num).toDouble(),
  details: json['details'] as String,
  category: json['category'] as String,
  discount: (json['discount'] as num?)?.toDouble(),
  favorite: json['favorite'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  imagesUrl:
      (json['images_url'] as List<dynamic>).map((e) => e as String).toList(),
  description: json['description'] as String,
  measurements: json['measurements'] as String,
  currencyCode: json['currency_code'] as String,
  packagingCount: (json['packaging_count'] as num).toInt(),
  packagingWidth: (json['packaging_width'] as num).toInt(),
  packagingHeight: (json['packaging_height'] as num).toDouble(),
  packagingLength: (json['packaging_length'] as num).toDouble(),
  packagingWeight: json['packaging_weight'] as String,
  discountEndDate:
      json['discount_end_date'] == null
          ? null
          : DateTime.parse(json['discount_end_date'] as String),
  productCategoryId: json['product_category_id'] as String,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'new': instance.productNew,
  'name': instance.name,
  'price': instance.price,
  'colors': instance.colors,
  'rating': instance.rating,
  'details': instance.details,
  'category': instance.category,
  'discount': instance.discount,
  'favorite': instance.favorite,
  'created_at': instance.createdAt.toIso8601String(),
  'images_url': instance.imagesUrl,
  'description': instance.description,
  'measurements': instance.measurements,
  'currency_code': instance.currencyCode,
  'packaging_count': instance.packagingCount,
  'packaging_width': instance.packagingWidth,
  'packaging_height': instance.packagingHeight,
  'packaging_length': instance.packagingLength,
  'packaging_weight': instance.packagingWeight,
  'discount_end_date': instance.discountEndDate?.toIso8601String(),
  'product_category_id': instance.productCategoryId,
};

Color _$ColorFromJson(Map<String, dynamic> json) =>
    Color(hex: json['hex'] as String, name: json['name'] as String);

Map<String, dynamic> _$ColorToJson(Color instance) => <String, dynamic>{
  'hex': instance.hex,
  'name': instance.name,
};

PopularBlogs _$PopularBlogsFromJson(Map<String, dynamic> json) => PopularBlogs(
  blogs:
      (json['blogs'] as List<dynamic>)
          .map((e) => Blog.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$PopularBlogsToJson(PopularBlogs instance) =>
    <String, dynamic>{'blogs': instance.blogs};

Blog _$BlogFromJson(Map<String, dynamic> json) => Blog(
  id: json['id'] as String,
  categoryId: json['category_id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  title: json['title'] as String,
  publisher: json['publisher'] as String,
  thumbnailUrl: json['thumbnail_url'] as String,
  introduction: json['introduction'] as String,
);

Map<String, dynamic> _$BlogToJson(Blog instance) => <String, dynamic>{
  'id': instance.id,
  'category_id': instance.categoryId,
  'created_at': instance.createdAt.toIso8601String(),
  'title': instance.title,
  'publisher': instance.publisher,
  'thumbnail_url': instance.thumbnailUrl,
  'introduction': instance.introduction,
};

PopularCategory _$PopularCategoryFromJson(Map<String, dynamic> json) =>
    PopularCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      discount: (json['discount'] as num?)?.toDouble(),
      discountEndDate:
          json['discount_end_date'] == null
              ? null
              : DateTime.parse(json['discount_end_date'] as String),
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$PopularCategoryToJson(PopularCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'discount': instance.discount,
      'discount_end_date': instance.discountEndDate?.toIso8601String(),
      'image_url': instance.imageUrl,
    };
