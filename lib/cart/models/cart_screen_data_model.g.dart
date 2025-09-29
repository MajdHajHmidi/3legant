// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_screen_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartScreenDataModel _$CartScreenDataModelFromJson(Map<String, dynamic> json) =>
    CartScreenDataModel(
      products:
          (json['products'] as List<dynamic>)
              .map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList(),
      shippingMethods:
          (json['shipping_methods'] as List<dynamic>)
              .map((e) => ShippingMethod.fromJson(e as Map<String, dynamic>))
              .toList(),
      totals: Totals.fromJson(json['totals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartScreenDataModelToJson(
  CartScreenDataModel instance,
) => <String, dynamic>{
  'products': instance.products,
  'shipping_methods': instance.shippingMethods,
  'totals': instance.totals,
};

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['id'] as String,
  productNew: json['new'] as bool,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  details: json['details'] as String,
  discount: (json['discount'] as num?)?.toDouble(),
  quantity: (json['quantity'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  imagesUrl:
      (json['images_url'] as List<dynamic>).map((e) => e as String).toList(),
  description: json['description'] as String,
  measurements: json['measurements'] as String,
  currencyCode: json['currency_code'] as String,
  selectedColor: SelectedColor.fromJson(
    json['selected_color'] as Map<String, dynamic>,
  ),
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
  'details': instance.details,
  'discount': instance.discount,
  'quantity': instance.quantity,
  'created_at': instance.createdAt.toIso8601String(),
  'images_url': instance.imagesUrl,
  'description': instance.description,
  'measurements': instance.measurements,
  'currency_code': instance.currencyCode,
  'selected_color': instance.selectedColor,
  'packaging_count': instance.packagingCount,
  'packaging_width': instance.packagingWidth,
  'packaging_height': instance.packagingHeight,
  'packaging_length': instance.packagingLength,
  'packaging_weight': instance.packagingWeight,
  'discount_end_date': instance.discountEndDate?.toIso8601String(),
  'product_category_id': instance.productCategoryId,
};

SelectedColor _$SelectedColorFromJson(Map<String, dynamic> json) =>
    SelectedColor(
      id: json['id'] as String,
      hex: json['hex'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SelectedColorToJson(SelectedColor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hex': instance.hex,
      'name': instance.name,
    };

ShippingMethod _$ShippingMethodFromJson(Map<String, dynamic> json) =>
    ShippingMethod(
      id: json['id'] as String,
      name: json['name'] as String,
      shortName: json['short_name'] as String,
      price: (json['price'] as num).toDouble(),
      currencyCode: json['currency_code'] as String,
    );

Map<String, dynamic> _$ShippingMethodToJson(ShippingMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'short_name': instance.shortName,
      'price': instance.price,
      'currency_code': instance.currencyCode,
    };

Totals _$TotalsFromJson(Map<String, dynamic> json) => Totals(
  subtotal: (json['subtotal'] as num?)?.toDouble(),
  discountedTotal: (json['discounted_total'] as num?)?.toDouble(),
);

Map<String, dynamic> _$TotalsToJson(Totals instance) => <String, dynamic>{
  'subtotal': instance.subtotal,
  'discounted_total': instance.discountedTotal,
};
