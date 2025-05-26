import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/util/localization.dart';
import '../../models/home_data_model.dart';
import 'package:flutter/material.dart';

class HomeStoreInfo extends StatelessWidget {
  final Metadata metadata;
  const HomeStoreInfo({super.key, required this.metadata});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    metadata.descriptiveTitle1 +
                    getValueWithDirection(context, ',', '،') +
                    '\n',
                style: AppTextStyles.headline4.copyWith(
                  color: AppColors.neutral_07,
                ),
              ),

              TextSpan(
                text: '${metadata.descriptiveTitle2}.',
                style: AppTextStyles.headline4.copyWith(
                  color: AppColors.neutral_07,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${metadata.appName} ',
                style: AppTextStyles.caption1Semi.copyWith(
                  color: AppColors.neutral_05,
                ),
              ),
              TextSpan(
                text: metadata.appDescription,
                style: AppTextStyles.caption1.copyWith(
                  color: AppColors.neutral_04,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
