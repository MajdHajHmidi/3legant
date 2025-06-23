import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/app_rating_bar.dart';
import 'package:e_commerce/product_details/models/product_details_model.dart';
import 'package:flutter/material.dart';

class ProductOverview extends StatelessWidget {
  final ProductDetailsModel model;
  const ProductOverview({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppRatingBar(rating: model.rating),
            const SizedBox(width: 10),
            Text(
              '${model.ratingsCount ?? 0} ${localization(context).ratings}',
              style: AppTextStyles.caption2.copyWith(
                color: AppColors.neutral_07,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          model.name,
          style: AppTextStyles.headline4.copyWith(color: AppColors.neutral_07),
        ),
        const SizedBox(height: 8),
        Text(
          model.description,
          style: AppTextStyles.body2.copyWith(color: AppColors.neutral_04),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Builder(
              builder: (context) {
                final currencySymbol = getCurrencySymbol(model.currencyCode);
                final productPrice =
                    model.discount == null
                        // No discounts? full price
                        ? model.price
                        // Discounted price
                        : model.price - (model.price * model.discount! / 100);
                return Flexible(
                  child: Text(
                    '$currencySymbol${productPrice.toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.headline6.copyWith(
                      color: AppColors.neutral_07,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            if (model.discount != null)
              Flexible(
                child: Text(
                  '${getCurrencySymbol(model.currencyCode)}${model.price.toStringAsFixed(2)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.headline7.copyWith(
                    color: AppColors.neutral_04,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
