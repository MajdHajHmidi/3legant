import 'package:e_commerce/core/constants/app_assets.dart';
import 'package:e_commerce/core/constants/app_constants.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/widgets/app_image.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              AppConstants.appName,
              style: AppTextStyles.headline6,
              textScaler: TextScaler.noScaling,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Flexible(
          flex: 4,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return AppAssetImage(
                assetPath: AppImages.authScreenChair,
                height: constraints.maxHeight * 0.75,
              );
            },
          ),
        ),
      ],
    );
  }
}
