// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsModel _$ProductDetailsModelFromJson(
  Map<String, dynamic> json,
) => ProductDetailsModel(
  id: json['id'] as String,
  isNew: json['new'] as bool,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  colors:
      (json['colors'] as List<dynamic>)
          .map((e) => Color.fromJson(e as Map<String, dynamic>))
          .toList(),
  rating: (json['rating'] as num).toDouble(),
  details: json['details'] as String,
  similarProducts:
      (json['similar_products'] as List<dynamic>?)
          ?.map((e) => ProductDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  category: json['category'] as String,
  discount: (json['discount'] as num?)?.toDouble(),
  isFavorite: json['favorite'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  imagesUrl:
      (json['images_url'] as List<dynamic>).map((e) => e as String).toList(),
  description: json['description'] as String,
  measurements: json['measurements'] as String,
  currencyCode: json['currency_code'] as String,
  ratingsCount: (json['ratings_count'] as num?)?.toInt(),
  reviewsCount: (json['reviews_count'] as num?)?.toInt(),
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

Map<String, dynamic> _$ProductDetailsModelToJson(
  ProductDetailsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'new': instance.isNew,
  'name': instance.name,
  'price': instance.price,
  'colors': instance.colors,
  'rating': instance.rating,
  'details': instance.details,
  'similar_products': instance.similarProducts,
  'category': instance.category,
  'discount': instance.discount,
  'favorite': instance.isFavorite,
  'created_at': instance.createdAt.toIso8601String(),
  'images_url': instance.imagesUrl,
  'description': instance.description,
  'measurements': instance.measurements,
  'currency_code': instance.currencyCode,
  'ratings_count': instance.ratingsCount,
  'reviews_count': instance.reviewsCount,
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
