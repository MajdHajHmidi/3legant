import '../../../core/navigation/router.dart';
import 'package:go_router/go_router.dart';

import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/util/localization.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_image.dart';
import '../../models/home_data_model.dart';
import 'package:flutter/material.dart';

class HomeSales extends StatelessWidget {
  final Metadata metadata;
  const HomeSales({super.key, required this.metadata});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppNetworkImage(
          imageUrl: metadata.discountBannerImageUrl,
          width: double.infinity,
          height: 350,
          fit: BoxFit.cover,
          alignment: Alignment(Alignment.center.x, Alignment.center.y + 0.3),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
          color: AppColors.neutral_02,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                metadata.discountBannerSalesInfo,
                style: AppTextStyles.hairline1.copyWith(color: AppColors.blue),
              ),
              const SizedBox(height: 16),
              Text(
                metadata.discountBannerTitle,
                style: AppTextStyles.headline5.copyWith(
                  color: AppColors.neutral_07,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                metadata.discountBannerSubtitle,
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.neutral_07,
                ),
              ),
              const SizedBox(height: 24),
              AppTextButton(
                text: localization(context).homeShopNow,
                onPressed: () => context.goNamed(AppRoutes.shop.name),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
