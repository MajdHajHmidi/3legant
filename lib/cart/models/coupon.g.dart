// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
  id: json['id'] as String?,
  code: json['code'] as String?,
  discount: (json['discount'] as num?)?.toDouble(),
);

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'discount': instance.discount,
};
