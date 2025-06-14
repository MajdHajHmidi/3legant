import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../models/home_data_model.dart';

class _AppFeautreData {
  final String title;
  final String subtitle;
  final String iconPath;

  const _AppFeautreData({
    required this.title,
    required this.subtitle,
    required this.iconPath,
  });
}

class HomeAppFeatures extends StatelessWidget {
  final Metadata metadata;
  const HomeAppFeatures({super.key, required this.metadata});

  @override
  Widget build(BuildContext context) {
    final appFeatures = [
      _AppFeautreData(
        title: metadata.appFeature1Title,
        subtitle: metadata.appFeature1Message,
        iconPath: AppIcons.delivery,
      ),
      _AppFeautreData(
        title: metadata.appFeature2Title,
        subtitle: metadata.appFeature2Message,
        iconPath: AppIcons.money,
      ),
      _AppFeautreData(
        title: metadata.appFeature3Title,
        subtitle: metadata.appFeature3Message,
        iconPath: AppIcons.lock,
      ),
      _AppFeautreData(
        title: metadata.appFeature4Title,
        subtitle: metadata.appFeature4Message,
        iconPath: AppIcons.call,
      ),
    ];

    return SliverGrid.builder(
      itemCount: appFeatures.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3 / 4,
        mainAxisExtent: 120 + (90 * MediaQuery.textScalerOf(context).scale(1)),
      ),

      itemBuilder: (context, index) {
        return _AppFeatureTile(data: appFeatures[index]);
      },
    );
  }
}

class _AppFeatureTile extends StatelessWidget {
  final _AppFeautreData data;
  const _AppFeatureTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 32, bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.neutral_02,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            data.iconPath,
            width: 48,
            height: 48,
            theme: SvgTheme(currentColor: AppColors.neutral_07),
          ),
          const SizedBox(height: 20),
          Text(
            data.title,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption1Semi.copyWith(
              color: AppColors.neutral_07,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.subtitle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: AppTextStyles.caption2.copyWith(color: AppColors.neutral_04),
          ),
        ],
      ),
    );
  }
}
