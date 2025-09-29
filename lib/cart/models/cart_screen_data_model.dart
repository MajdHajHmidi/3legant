import 'package:json_annotation/json_annotation.dart';

part 'cart_screen_data_model.g.dart';

@JsonSerializable()
class CartScreenDataModel {
    @JsonKey(name: "products")
    final List<Product> products;
    @JsonKey(name: "shipping_methods")
    final List<ShippingMethod> shippingMethods;
    @JsonKey(name: "totals")
    final Totals totals;

    CartScreenDataModel({
        required this.products,
        required this.shippingMethods,
        required this.totals,
    });

    CartScreenDataModel copyWith({
        List<Product>? products,
        List<ShippingMethod>? shippingMethods,
        Totals? totals,
    }) => 
        CartScreenDataModel(
            products: products ?? this.products,
            shippingMethods: shippingMethods ?? this.shippingMethods,
            totals: totals ?? this.totals,
        );

    factory CartScreenDataModel.fromJson(Map<String, dynamic> json) => _$CartScreenDataModelFromJson(json);

    Map<String, dynamic> toJson() => _$CartScreenDataModelToJson(this);
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
    @JsonKey(name: "details")
    final String details;
    @JsonKey(name: "discount")
    final double? discount;
    @JsonKey(name: "quantity")
    final int quantity;
    @JsonKey(name: "created_at")
    final DateTime createdAt;
    @JsonKey(name: "images_url")
    final List<String> imagesUrl;
    @JsonKey(name: "description")
    final String description;
    @JsonKey(name: "measurements")
    final String measurements;
    @JsonKey(name: "currency_code")
    final String currencyCode;
    @JsonKey(name: "selected_color")
    final SelectedColor selectedColor;
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
        required this.details,
        required this.discount,
        required this.quantity,
        required this.createdAt,
        required this.imagesUrl,
        required this.description,
        required this.measurements,
        required this.currencyCode,
        required this.selectedColor,
        required this.packagingCount,
        required this.packagingWidth,
        required this.packagingHeight,
        required this.packagingLength,
        required this.packagingWeight,
        required this.discountEndDate,
        required this.productCategoryId,
    });

    Product copyWith({
        String? id,
        bool? productNew,
        String? name,
        double? price,
        String? details,
        double? discount,
        int? quantity,
        DateTime? createdAt,
        List<String>? imagesUrl,
        String? description,
        String? measurements,
        String? currencyCode,
        SelectedColor? selectedColor,
        int? packagingCount,
        int? packagingWidth,
        double? packagingHeight,
        double? packagingLength,
        String? packagingWeight,
        DateTime? discountEndDate,
        String? productCategoryId,
    }) => 
        Product(
            id: id ?? this.id,
            productNew: productNew ?? this.productNew,
            name: name ?? this.name,
            price: price ?? this.price,
            details: details ?? this.details,
            discount: discount ?? this.discount,
            quantity: quantity ?? this.quantity,
            createdAt: createdAt ?? this.createdAt,
            imagesUrl: imagesUrl ?? this.imagesUrl,
            description: description ?? this.description,
            measurements: measurements ?? this.measurements,
            currencyCode: currencyCode ?? this.currencyCode,
            selectedColor: selectedColor ?? this.selectedColor,
            packagingCount: packagingCount ?? this.packagingCount,
            packagingWidth: packagingWidth ?? this.packagingWidth,
            packagingHeight: packagingHeight ?? this.packagingHeight,
            packagingLength: packagingLength ?? this.packagingLength,
            packagingWeight: packagingWeight ?? this.packagingWeight,
            discountEndDate: discountEndDate ?? this.discountEndDate,
            productCategoryId: productCategoryId ?? this.productCategoryId,
        );

    factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

    Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class SelectedColor {
    @JsonKey(name: "id")
    final String id;
    @JsonKey(name: "hex")
    final String hex;
    @JsonKey(name: "name")
    final String name;

    SelectedColor({
        required this.id,
        required this.hex,
        required this.name,
    });

    SelectedColor copyWith({
        String? id,
        String? hex,
        String? name,
    }) => 
        SelectedColor(
            id: id ?? this.id,
            hex: hex ?? this.hex,
            name: name ?? this.name,
        );

    factory SelectedColor.fromJson(Map<String, dynamic> json) => _$SelectedColorFromJson(json);

    Map<String, dynamic> toJson() => _$SelectedColorToJson(this);
}

@JsonSerializable()
class ShippingMethod {
    @JsonKey(name: "id")
    final String id;
    @JsonKey(name: "name")
    final String name;
    @JsonKey(name: "short_name")
    final String shortName;
    @JsonKey(name: "price")
    final double price;
    @JsonKey(name: "currency_code")
    final String currencyCode;

    ShippingMethod({
        required this.id,
        required this.name,
        required this.shortName,
        required this.price,
        required this.currencyCode,
    });

    ShippingMethod copyWith({
        String? id,
        String? name,
        String? shortName,
        double? price,
        String? currencyCode,
    }) => 
        ShippingMethod(
            id: id ?? this.id,
            name: name ?? this.name,
            shortName: shortName ?? this.shortName,
            price: price ?? this.price,
            currencyCode: currencyCode ?? this.currencyCode,
        );

    factory ShippingMethod.fromJson(Map<String, dynamic> json) => _$ShippingMethodFromJson(json);

    Map<String, dynamic> toJson() => _$ShippingMethodToJson(this);
}

@JsonSerializable()
class Totals {
    @JsonKey(name: "subtotal")
    final double? subtotal;
    @JsonKey(name: "discounted_total")
    final double? discountedTotal;

    Totals({
        required this.subtotal,
        required this.discountedTotal,
    });

    Totals copyWith({
        double? subtotal,
        double? discountedTotal,
    }) => 
        Totals(
            subtotal: subtotal ?? this.subtotal,
            discountedTotal: discountedTotal ?? this.discountedTotal,
        );

    factory Totals.fromJson(Map<String, dynamic> json) => _$TotalsFromJson(json);

    Map<String, dynamic> toJson() => _$TotalsToJson(this);
}
