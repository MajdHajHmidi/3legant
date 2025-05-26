import '../../../core/navigation/router.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/util/localization.dart';
import '../../../core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeBlogsTitle extends StatelessWidget {
  const HomeBlogsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            localization(context).blogs,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.headline5.copyWith(
              color: AppColors.neutral_07,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Align(
            alignment: getValueWithDirection(
              context,
              Alignment.centerRight,
              Alignment.centerLeft,
            ),
            child: AppTextButton(
              text: localization(context).moreBlogs,
              onPressed: () => context.pushNamed(AppRoutes.blogs.name),
            ),
          ),
        ),
      ],
    );
  }
}
