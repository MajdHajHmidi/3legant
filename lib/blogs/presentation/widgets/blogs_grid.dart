import '../../models/blogs_data_model.dart';
import 'blog_tile.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/widgets/app_adaptive_grid.dart';
import 'package:flutter/material.dart';

class BlogsGrid extends StatelessWidget {
  final List<Blog> blogs;
  const BlogsGrid({super.key, required this.blogs});

  @override
  Widget build(BuildContext context) {
    return AppAdaptiveSliverGrid(
      itembuilder: (context, index) => BlogTile(blog: blogs[index]),
      itemCount: blogs.length,
      minimumTileWidth: 300.0,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      staticChildHeight: 320,
      textPlaceholders: [
        TextPlaceholderParams(
          context: context,
          texts: blogs.map((blog) => blog.title).toList(),
          horizontalPadding: 8,
          style: AppTextStyles.body2Semi,
          maxLines: 2,
        ),
        TextPlaceholderParams(
          context: context,
          text: 'September 30, 2025', // Sample that applies to all other cases
          style: AppTextStyles.caption2,
          maxLines: 1,
          horizontalPadding: 8,
        ),
      ],
    );
  }
}
