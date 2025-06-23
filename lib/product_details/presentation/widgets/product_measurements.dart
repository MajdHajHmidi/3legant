import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/product_details/models/product_details_model.dart';
import 'package:flutter/material.dart';

class ProductMeasurements extends StatelessWidget {
  final ProductDetailsModel model;
  const ProductMeasurements({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localization(context).measurements,
          style: AppTextStyles.body2Semi.copyWith(color: AppColors.neutral_04),
        ),
        SizedBox(height: 8),
        Text(
          model.measurements,
          style: AppTextStyles.body1.copyWith(color: AppColors.neutral_07),
        ),
      ],
    );
  }
}
