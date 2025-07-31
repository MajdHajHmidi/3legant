import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import 'package:e_commerce/core/constants/app_assets.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/util/testing.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_image.dart';
import 'package:e_commerce/profile/domain/profile_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FavoriteProductTile extends StatelessWidget {
  final Product product;
  const FavoriteProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppNetworkImage(
          imageUrl: product.thumbnail,
          height: 128,
          width: 108,
          borderRadius: BorderRadius.circular(8),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.caption1Semi.copyWith(
                      color: AppColors.neutral_07,
                    ),
                  ),
                  const Spacer(),
                  Ink(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0xFFFF5630).withAlpha(38),
                    ),
                    child: SvgPicture.asset(
                      AppIcons.trash,
                      // ignore: deprecated_member_use
                      color: Color(0xFFFF5630).withAlpha(191),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                '${getCurrencySymbol(product.currencyCode)}${product.price.toStringAsFixed(2)}',
                style: AppTextStyles.caption1Semi.copyWith(
                  color: AppColors.neutral_07,
                ),
              ),
              SizedBox(height: 12),
              SecondaryAppButton(
                text: localization(context).addToCart,
                onPressed: () => showNotImplementedDialog(context),
                height: 40,
                textStyle: AppTextStyles.caption1.copyWith(
                  color: AppColors.neutral_01,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
