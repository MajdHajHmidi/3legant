import 'package:e_commerce/core/constants/app_constants.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/responsive_builder.dart';
import 'package:e_commerce/core/widgets/network_image.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppNetworkImage(
          imageUrl: AppConstants.authImageUrl,
          width: double.infinity,
        ),
        ResponsiveBuilder(
          mobile:
              (context) => SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      '3legant.',
                      style: AppTextStyles.headline6,
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                ),
              ),
          tablet:
              (context) => SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      '3legant.',
                      style: AppTextStyles.headline6,
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                ),
              ),
        ),
      ],
    );
  }
}
