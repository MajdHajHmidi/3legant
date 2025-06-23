import 'package:e_commerce/core/constants/app_assets.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppRatingBar extends StatelessWidget {
  final bool _interactive;
  final double rating;
  final void Function(double rating)? onUpdate;
  const AppRatingBar({super.key, required this.rating})
    : _interactive = false,
      onUpdate = null;

  const AppRatingBar.interactive({
    super.key,
    required this.rating,
    required this.onUpdate,
  }) : _interactive = true;

  double roundToHalves(double value) {
    return (value * 2).round() / 2;
  }

  @override
  Widget build(BuildContext context) {
    if (_interactive) {
      return RatingBar.builder(
        // Round to closest 0.5 step
        initialRating: rating,
        itemBuilder:
            (context, index) => SvgPicture.asset(
              AppIcons.rating,
              theme: SvgTheme(currentColor: AppColors.neutral_05),
            ),
        itemCount: 5,
        itemSize: 36,
        glow: false,
        allowHalfRating: true,
        unratedColor: AppColors.neutral_03,
        itemPadding: const EdgeInsets.symmetric(horizontal: 1),
        onRatingUpdate: onUpdate!,
      );
    }

    return RatingBarIndicator(
      // Round to closest 0.5 step
      rating: roundToHalves(rating),
      itemBuilder:
          (context, index) => SvgPicture.asset(
            AppIcons.rating,
            theme: SvgTheme(currentColor: AppColors.neutral_05),
          ),
      itemCount: 5,
      itemSize: 16,
      unratedColor: AppColors.neutral_03,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1),
    );
  }
}
