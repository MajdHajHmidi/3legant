import 'package:json_annotation/json_annotation.dart';

part 'blog_details_data_model.g.dart';

@JsonSerializable()
class BlogDetailsDataModel {
  @JsonKey(name: "blog_details")
  final BlogDetails blogDetails;
  @JsonKey(name: "content")
  final List<Content> content;
  @JsonKey(name: "similar_blogs")
  final List<BlogDetails> similarBlogs;

  BlogDetailsDataModel({
    required this.blogDetails,
    required this.content,
    required this.similarBlogs,
  });

  factory BlogDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      _$BlogDetailsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlogDetailsDataModelToJson(this);
}

@JsonSerializable()
class BlogDetails {
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
  final String? blogCategory;

  BlogDetails({
    required this.id,
    required this.categoryId,
    required this.createdAt,
    required this.title,
    required this.publisher,
    required this.thumbnailUrl,
    required this.introduction,
    required this.blogCategory,
  });

  factory BlogDetails.fromJson(Map<String, dynamic> json) =>
      _$BlogDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BlogDetailsToJson(this);
}

@JsonSerializable()
class Content {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "heading")
  final String? heading;
  @JsonKey(name: "text")
  final String text;
  @JsonKey(name: "image_url")
  final String? imageUrl;
  @JsonKey(name: "order")
  final int order;

  Content({
    required this.id,
    this.heading,
    required this.text,
    required this.imageUrl,
    required this.order,
  });

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
