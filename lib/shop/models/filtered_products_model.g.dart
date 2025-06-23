// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtered_products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilteredProductsModel _$FilteredProductsModelFromJson(
  Map<String, dynamic> json,
) => FilteredProductsModel(
  products:
      (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
  paginationInfo: PaginationInfo.fromJson(
    json['pagination_info'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$FilteredProductsModelToJson(
  FilteredProductsModel instance,
) => <String, dynamic>{
  'products': instance.products,
  'pagination_info': instance.paginationInfo,
};

PaginationInfo _$PaginationInfoFromJson(Map<String, dynamic> json) =>
    PaginationInfo(
      currentPage: (json['current_page'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
      totalItems: (json['total_items'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationInfoToJson(PaginationInfo instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'page_size': instance.pageSize,
      'total_items': instance.totalItems,
      'total_pages': instance.totalPages,
    };

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
