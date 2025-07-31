import 'package:json_annotation/json_annotation.dart';

part 'profile_data_model.g.dart';

@JsonSerializable()
class ProfileDataModel {
  @JsonKey(name: "orders")
  final List<Order> orders;
  @JsonKey(name: "account")
  final AccountDetails accountDetails;
  @JsonKey(name: "favorite_products")
  final List<Product> favoriteProducts;

  ProfileDataModel({
    required this.orders,
    required this.accountDetails,
    required this.favoriteProducts,
  });

  ProfileDataModel copyWith({
    List<Order>? orders,
    AccountDetails? accountDetails,
    List<Product>? favoriteProducts,
  }) => ProfileDataModel(
    orders: orders ?? this.orders,
    accountDetails: accountDetails ?? this.accountDetails,
    favoriteProducts: favoriteProducts ?? this.favoriteProducts,
  );

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataModelToJson(this);
}

@JsonSerializable()
class AccountDetails {
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "display_name")
  final String displayName;
  @JsonKey(name: "profile_image")
  final String? profileImage;

  AccountDetails({
    required this.email,
    required this.displayName,
    required this.profileImage,
  });

  AccountDetails copyWith({
    String? email,
    String? displayName,
    String? profileImage,
  }) => AccountDetails(
    email: email ?? this.email,
    displayName: displayName ?? this.displayName,
    profileImage: profileImage ?? this.profileImage,
  );

  factory AccountDetails.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDetailsToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "price")
  final double price;
  @JsonKey(name: "thumbnail")
  final String thumbnail;
  @JsonKey(name: "currency_code")
  final String currencyCode;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.thumbnail,
    required this.currencyCode,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Order {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "user_id")
  final String userId;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "price")
  final int price;
  @JsonKey(name: "currency_code")
  final String currencyCode;

  Order({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.status,
    required this.price,
    required this.currencyCode,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
