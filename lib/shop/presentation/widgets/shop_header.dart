import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/widgets/app_image.dart';
import '../../models/shop_data_model.dart';
import 'package:flutter/material.dart';

class ShopHeader extends StatelessWidget {
  final Metadata metadata;
  const ShopHeader({super.key, required this.metadata});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: AppNetworkImage(
              imageUrl: metadata.shopPageThumbnailUrl,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(60),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      metadata.shopPageTitle,
                      textScaler: TextScaler.linear(1),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headline4.copyWith(
                        color: AppColors.neutral_03,
                      ),
                    ),
                    Text(
                      metadata.shopPageSubtitle,
                      textScaler: TextScaler.linear(1),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.neutral_03,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
