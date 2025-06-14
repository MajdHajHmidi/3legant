// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopDataModel _$ShopDataModelFromJson(Map<String, dynamic> json) =>
    ShopDataModel(
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      currencyCode: json['currency_code'] as String,
      categories:
          (json['categories'] as List<dynamic>)
              .map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList(),
      totalPriceRange: PriceRange.fromJson(
        json['total_price_range'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ShopDataModelToJson(ShopDataModel instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'currency_code': instance.currencyCode,
      'categories': instance.categories,
      'total_price_range': instance.totalPriceRange,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: json['id'] as String,
  name: json['name'] as String,
  discount: (json['discount'] as num?)?.toDouble(),
  discountEndDate:
      json['discount_end_date'] == null
          ? null
          : DateTime.parse(json['discount_end_date'] as String),
  priceRange: PriceRange.fromJson(json['price_range'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'discount': instance.discount,
  'discount_end_date': instance.discountEndDate?.toIso8601String(),
  'price_range': instance.priceRange,
};

PriceRange _$PriceRangeFromJson(Map<String, dynamic> json) => PriceRange(
  minPrice: (json['min_price'] as num).toDouble(),
  maxPrice: (json['max_price'] as num).toDouble(),
);

Map<String, dynamic> _$PriceRangeToJson(PriceRange instance) =>
    <String, dynamic>{
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
  shopPageTitle: json['shop_page_title'] as String,
  shopPageSubtitle: json['shop_page_subtitle'] as String,
  shopPageThumbnailUrl: json['shop_page_thumbnail_url'] as String,
);

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
  'shop_page_title': instance.shopPageTitle,
  'shop_page_subtitle': instance.shopPageSubtitle,
  'shop_page_thumbnail_url': instance.shopPageThumbnailUrl,
};
