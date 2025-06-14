import '../../models/blog_details_data_model.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/widgets/app_image.dart';
import 'package:flutter/material.dart';

class BlogContentTile extends StatelessWidget {
  final Content content;
  const BlogContentTile({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (content.imageUrl != null)
          AppNetworkImage(
            imageUrl: content.imageUrl!,
            height: 400,
            width: double.infinity,
            borderRadius: BorderRadius.circular(12),
          ),
        const SizedBox(height: 16),
        if (content.heading != null)
          Text(
            content.heading!,
            style: AppTextStyles.headline6.copyWith(
              color: AppColors.neutral_07,
            ),
          ),
        Text(
          content.text,
          style: AppTextStyles.body2.copyWith(color: AppColors.neutral_07),
        ),
      ],
    );
  }
}
