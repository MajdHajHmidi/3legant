// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_reviews_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductReviewsModel _$ProductReviewsModelFromJson(Map<String, dynamic> json) =>
    ProductReviewsModel(
      reviews:
          (json['ratings'] as List<dynamic>)
              .map((e) => Rating.fromJson(e as Map<String, dynamic>))
              .toList(),
      paginationInfo: PaginationInfo.fromJson(
        json['pagination_info'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ProductReviewsModelToJson(
  ProductReviewsModel instance,
) => <String, dynamic>{
  'ratings': instance.reviews,
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

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  userId: json['user_id'] as String,
  productId: json['product_id'] as String,
  rating: (json['rating'] as num).toDouble(),
  comment: json['comment'] as String?,
  userName: json['user_name'] as String,
  userAvatar: json['user_avatar'] as String?,
);

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'user_id': instance.userId,
  'product_id': instance.productId,
  'rating': instance.rating,
  'comment': instance.comment,
  'user_name': instance.userName,
  'user_avatar': instance.userAvatar,
};
