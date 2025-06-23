class Product {
  final String id;
  final bool productNew;
  final String name;
  final double price;
  final double rating;
  final String details;
  final bool favorite;
  final List<String> imagesUrl;
  final String description;
  final String measurements;
  final String currencyCode;
  final double? discount;
  final DateTime? discountEndDate;

  Product({
    required this.id,
    required this.productNew,
    required this.name,
    required this.price,
    required this.rating,
    required this.details,
    required this.discount,
    required this.favorite,
    required this.imagesUrl,
    required this.description,
    required this.measurements,
    required this.currencyCode,
    required this.discountEndDate,
  });
}
