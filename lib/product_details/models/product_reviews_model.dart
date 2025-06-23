import 'package:json_annotation/json_annotation.dart';

part 'product_reviews_model.g.dart';

@JsonSerializable()
class ProductReviewsModel {
  @JsonKey(name: "ratings")
  final List<Rating> reviews;
  @JsonKey(name: "pagination_info")
  final PaginationInfo paginationInfo;

  ProductReviewsModel({required this.reviews, required this.paginationInfo});

  factory ProductReviewsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewsModelToJson(this);
}

@JsonSerializable()
class PaginationInfo {
  @JsonKey(name: "current_page")
  final int currentPage;
  @JsonKey(name: "page_size")
  final int pageSize;
  @JsonKey(name: "total_items")
  final int totalItems;
  @JsonKey(name: "total_pages")
  final int totalPages;

  PaginationInfo({
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationInfoToJson(this);
}

@JsonSerializable()
class Rating {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "user_id")
  final String userId;
  @JsonKey(name: "product_id")
  final String productId;
  @JsonKey(name: "rating")
  final double rating;
  @JsonKey(name: "comment")
  final String? comment;
  @JsonKey(name: "user_name")
  final String userName;
  @JsonKey(name: "user_avatar")
  final String? userAvatar;

  Rating({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.productId,
    required this.rating,
    required this.comment,
    required this.userName,
    this.userAvatar,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
