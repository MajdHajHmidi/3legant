// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDataModel _$ProfileDataModelFromJson(Map<String, dynamic> json) =>
    ProfileDataModel(
      orders:
          (json['orders'] as List<dynamic>)
              .map((e) => Order.fromJson(e as Map<String, dynamic>))
              .toList(),
      accountDetails: AccountDetails.fromJson(
        json['account'] as Map<String, dynamic>,
      ),
      favoriteProducts:
          (json['favorite_products'] as List<dynamic>)
              .map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ProfileDataModelToJson(ProfileDataModel instance) =>
    <String, dynamic>{
      'orders': instance.orders,
      'account': instance.accountDetails,
      'favorite_products': instance.favoriteProducts,
    };

AccountDetails _$AccountDetailsFromJson(Map<String, dynamic> json) =>
    AccountDetails(
      email: json['email'] as String,
      displayName: json['display_name'] as String,
      profileImage: json['profile_image'] as String?,
    );

Map<String, dynamic> _$AccountDetailsToJson(AccountDetails instance) =>
    <String, dynamic>{
      'email': instance.email,
      'display_name': instance.displayName,
      'profile_image': instance.profileImage,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['id'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  thumbnail: json['thumbnail'] as String,
  currencyCode: json['currency_code'] as String,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'price': instance.price,
  'thumbnail': instance.thumbnail,
  'currency_code': instance.currencyCode,
};

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  status: json['status'] as String,
  price: (json['price'] as num).toInt(),
  currencyCode: json['currency_code'] as String,
);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'created_at': instance.createdAt.toIso8601String(),
  'status': instance.status,
  'price': instance.price,
  'currency_code': instance.currencyCode,
};
