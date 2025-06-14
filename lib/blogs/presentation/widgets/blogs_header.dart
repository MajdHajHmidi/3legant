import '../../models/blogs_data_model.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/widgets/app_image.dart';
import 'package:flutter/material.dart';

class BlogsHeader extends StatelessWidget {
  final BlogsMetadata metadata;
  const BlogsHeader({super.key, required this.metadata});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            AppNetworkImage(
              width: double.infinity,
              height: 300,
              imageUrl: metadata.blogsScreenThumbnailUrl,
              borderRadius: BorderRadius.circular(12),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        metadata.blogsScreenTitle,
                        textScaler: TextScaler.linear(1),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headline4.copyWith(
                          color: AppColors.neutral_07,
                        ),
                      ),
                      Text(
                        metadata.blogsScreenSubtitle,
                        textScaler: TextScaler.linear(1),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.neutral_07,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
