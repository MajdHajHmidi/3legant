import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/product_details/models/product_details_model.dart';
import 'package:flutter/material.dart';

class ProductCategory extends StatelessWidget {
  final ProductDetailsModel model;
  const ProductCategory({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          localization(context).category.toUpperCase(),
          style: AppTextStyles.caption2.copyWith(color: AppColors.neutral_04),
        ),
        SizedBox(width: 60),
        Flexible(
          child: Text(
            model.category,
            style: AppTextStyles.caption1.copyWith(color: AppColors.neutral_07),
          ),
        ),
      ],
    );
  }
}
