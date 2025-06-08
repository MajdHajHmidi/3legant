import 'package:json_annotation/json_annotation.dart';

part 'blogs_data_model.g.dart';

@JsonSerializable()
class BlogsDataModel {
    @JsonKey(name: "blogs_metadata")
    final BlogsMetadata blogsMetadata;
    @JsonKey(name: "blogs")
    final List<Blog> blogs;
    @JsonKey(name: "blog_categories")
    final List<BlogCategory> blogCategories;
    @JsonKey(name: "pagination_info")
    final PaginationInfo paginationInfo;

    BlogsDataModel({
        required this.blogsMetadata,
        required this.blogs,
        required this.blogCategories,
        required this.paginationInfo,
    });

    factory BlogsDataModel.fromJson(Map<String, dynamic> json) => _$BlogsDataModelFromJson(json);

    Map<String, dynamic> toJson() => _$BlogsDataModelToJson(this);
}

@JsonSerializable()
class BlogCategory {
    @JsonKey(name: "id")
    final String id;
    @JsonKey(name: "name")
    final String name;

    BlogCategory({
        required this.id,
        required this.name,
    });

    factory BlogCategory.fromJson(Map<String, dynamic> json) => _$BlogCategoryFromJson(json);

    Map<String, dynamic> toJson() => _$BlogCategoryToJson(this);
}

@JsonSerializable()
class Blog {
    @JsonKey(name: "id")
    final String id;
    @JsonKey(name: "category_id")
    final String categoryId;
    @JsonKey(name: "created_at")
    final DateTime createdAt;
    @JsonKey(name: "title")
    final String title;
    @JsonKey(name: "publisher")
    final String publisher;
    @JsonKey(name: "thumbnail_url")
    final String thumbnailUrl;
    @JsonKey(name: "introduction")
    final String introduction;
    @JsonKey(name: "blog_category")
    final String blogCategory;

    Blog({
        required this.id,
        required this.categoryId,
        required this.createdAt,
        required this.title,
        required this.publisher,
        required this.thumbnailUrl,
        required this.introduction,
        required this.blogCategory,
    });

    factory Blog.fromJson(Map<String, dynamic> json) => _$BlogFromJson(json);

    Map<String, dynamic> toJson() => _$BlogToJson(this);
}

@JsonSerializable()
class BlogsMetadata {
    @JsonKey(name: "blogs_screen_title")
    final String blogsScreenTitle;
    @JsonKey(name: "blogs_screen_subtitle")
    final String blogsScreenSubtitle;
    @JsonKey(name: "blogs_screen_thumbnail_url")
    final String blogsScreenThumbnailUrl;

    BlogsMetadata({
        required this.blogsScreenTitle,
        required this.blogsScreenSubtitle,
        required this.blogsScreenThumbnailUrl,
    });

    factory BlogsMetadata.fromJson(Map<String, dynamic> json) => _$BlogsMetadataFromJson(json);

    Map<String, dynamic> toJson() => _$BlogsMetadataToJson(this);
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

    factory PaginationInfo.fromJson(Map<String, dynamic> json) => _$PaginationInfoFromJson(json);

    Map<String, dynamic> toJson() => _$PaginationInfoToJson(this);
}
