import 'package:json_annotation/json_annotation.dart';

part 'coupon.g.dart';

@JsonSerializable()
class Coupon {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "code")
  final String? code;
  @JsonKey(name: "discount")
  final double? discount;

  Coupon({required this.id, required this.code, required this.discount});

  Coupon copyWith({String? id, String? code, double? discount}) => Coupon(
    id: id ?? this.id,
    code: code ?? this.code,
    discount: discount ?? this.discount,
  );

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
