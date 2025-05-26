import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/util/localization.dart';
import '../../../core/util/testing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_image.dart';
import '../../models/home_data_model.dart';
import 'package:flutter/material.dart';

class HomeBlogTile extends StatelessWidget {
  final Blog blog;
  const HomeBlogTile({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => showNotImplementedDialog(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppNetworkImage(
              imageUrl: blog.thumbnailUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              borderRadius: BorderRadius.circular(12),
              alignment: Alignment(
                Alignment.center.x,
                Alignment.center.y + 0.3,
              ),
              height: 280,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    blog.title,
                    style: AppTextStyles.body2Semi.copyWith(
                      color: AppColors.neutral_07,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppTextButton(text: localization(context).readMore),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
