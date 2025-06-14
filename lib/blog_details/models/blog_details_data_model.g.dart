// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_details_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogDetailsDataModel _$BlogDetailsDataModelFromJson(
  Map<String, dynamic> json,
) => BlogDetailsDataModel(
  blogDetails: BlogDetails.fromJson(
    json['blog_details'] as Map<String, dynamic>,
  ),
  content:
      (json['content'] as List<dynamic>)
          .map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
  similarBlogs:
      (json['similar_blogs'] as List<dynamic>)
          .map((e) => BlogDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$BlogDetailsDataModelToJson(
  BlogDetailsDataModel instance,
) => <String, dynamic>{
  'blog_details': instance.blogDetails,
  'content': instance.content,
  'similar_blogs': instance.similarBlogs,
};

BlogDetails _$BlogDetailsFromJson(Map<String, dynamic> json) => BlogDetails(
  id: json['id'] as String,
  categoryId: json['category_id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  title: json['title'] as String,
  publisher: json['publisher'] as String,
  thumbnailUrl: json['thumbnail_url'] as String,
  introduction: json['introduction'] as String,
  blogCategory: json['blog_category'] as String?,
);

Map<String, dynamic> _$BlogDetailsToJson(BlogDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'created_at': instance.createdAt.toIso8601String(),
      'title': instance.title,
      'publisher': instance.publisher,
      'thumbnail_url': instance.thumbnailUrl,
      'introduction': instance.introduction,
      'blog_category': instance.blogCategory,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
  id: json['id'] as String,
  heading: json['heading'] as String,
  text: json['text'] as String,
  imageUrl: json['image_url'] as String?,
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'id': instance.id,
  'heading': instance.heading,
  'text': instance.text,
  'image_url': instance.imageUrl,
  'order': instance.order,
};
