// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blogs_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogsDataModel _$BlogsDataModelFromJson(Map<String, dynamic> json) =>
    BlogsDataModel(
      blogsMetadata: BlogsMetadata.fromJson(
        json['blogs_metadata'] as Map<String, dynamic>,
      ),
      blogs:
          (json['blogs'] as List<dynamic>)
              .map((e) => Blog.fromJson(e as Map<String, dynamic>))
              .toList(),
      blogCategories:
          (json['blog_categories'] as List<dynamic>)
              .map((e) => BlogCategory.fromJson(e as Map<String, dynamic>))
              .toList(),
      paginationInfo: PaginationInfo.fromJson(
        json['pagination_info'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$BlogsDataModelToJson(BlogsDataModel instance) =>
    <String, dynamic>{
      'blogs_metadata': instance.blogsMetadata,
      'blogs': instance.blogs,
      'blog_categories': instance.blogCategories,
      'pagination_info': instance.paginationInfo,
    };

BlogCategory _$BlogCategoryFromJson(Map<String, dynamic> json) =>
    BlogCategory(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$BlogCategoryToJson(BlogCategory instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

Blog _$BlogFromJson(Map<String, dynamic> json) => Blog(
  id: json['id'] as String,
  categoryId: json['category_id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  title: json['title'] as String,
  publisher: json['publisher'] as String,
  thumbnailUrl: json['thumbnail_url'] as String,
  introduction: json['introduction'] as String,
  blogCategory: json['blog_category'] as String,
);

Map<String, dynamic> _$BlogToJson(Blog instance) => <String, dynamic>{
  'id': instance.id,
  'category_id': instance.categoryId,
  'created_at': instance.createdAt.toIso8601String(),
  'title': instance.title,
  'publisher': instance.publisher,
  'thumbnail_url': instance.thumbnailUrl,
  'introduction': instance.introduction,
  'blog_category': instance.blogCategory,
};

BlogsMetadata _$BlogsMetadataFromJson(Map<String, dynamic> json) =>
    BlogsMetadata(
      blogsScreenTitle: json['blogs_screen_title'] as String,
      blogsScreenSubtitle: json['blogs_screen_subtitle'] as String,
      blogsScreenThumbnailUrl: json['blogs_screen_thumbnail_url'] as String,
    );

Map<String, dynamic> _$BlogsMetadataToJson(BlogsMetadata instance) =>
    <String, dynamic>{
      'blogs_screen_title': instance.blogsScreenTitle,
      'blogs_screen_subtitle': instance.blogsScreenSubtitle,
      'blogs_screen_thumbnail_url': instance.blogsScreenThumbnailUrl,
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
