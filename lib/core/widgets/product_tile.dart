import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import '../constants/app_assets.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../util/localization.dart';
import '../util/testing.dart';
import 'app_button.dart';
import 'app_image.dart';
import '../../favorite/presentation/widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final int index;
  final int productsLength;
  final void Function() onTap;
  final bool horizontalMode;
  final bool _detailedView;

  /// The callback that runs when the favorite is successfully toggled
  /// This runs after the data been changed on the server side
  /// It's useful for changing the `favorite` propery in the model to sync states
  final void Function()? favoriteRequestSuccessCallback;
  const ProductTile({
    super.key,
    required this.product,
    required this.index,
    required this.productsLength,
    required this.onTap,
    this.horizontalMode = true,
    this.favoriteRequestSuccessCallback,
  }) : _detailedView = false;

  const ProductTile.detailed({
    super.key,
    required this.product,
    required this.index,
    required this.productsLength,
    required this.onTap,
    this.horizontalMode = true,
    this.favoriteRequestSuccessCallback,
  }) : _detailedView = true;

  // For LTR locales, the first element has a 32px left padding, while RTL only 8, and the opposite for right padding
  // Same goes for the last element
  EdgeInsets getItemPadding(BuildContext context) {
    final defaultPadding = const EdgeInsets.only(right: 8, left: 8);

    if (!horizontalMode) {
      return defaultPadding;
    }

    if (index == 0) {
      return EdgeInsets.only(
        right: getValueWithDirection(context, 8.0, 32.0),
        left: getValueWithDirection(context, 32.0, 8.0),
      );
    } else if (index == productsLength - 1) {
      return EdgeInsets.only(
        right: getValueWithDirection(context, 32.0, 8.0),
        left: getValueWithDirection(context, 8.0, 32.0),
      );
    }

    return defaultPadding;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getItemPadding(context),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: SizedBox(
            width: 230,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: _detailedView ? 400 : 310,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: AppNetworkImage(
                            imageUrl: product.imagesUrl.first,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 16.0,
                          left: 16,
                          right: 16,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product.productNew ||
                                  product.discount != null)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: product.discount != null ? 8 : 5,
                                    horizontal:
                                        product.discount != null ? 10 : 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: HexColor('#141718').withAlpha(115),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (product.productNew)
                                        Container(
                                          width: 70,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              localization(
                                                context,
                                              ).newCapitalized,
                                              textScaler: TextScaler.linear(1),
                                              style: AppTextStyles.hairline1
                                                  .copyWith(
                                                    color: AppColors.neutral_07,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      if (product.discount != null &&
                                          product.productNew)
                                        const SizedBox(height: 8),
                                      if (product.discount != null)
                                        Container(
                                          width: 70,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            color: AppColors.green,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '-${product.discount!}%',
                                              textScaler: TextScaler.linear(1),
                                              style: AppTextStyles.hairline1
                                                  .copyWith(
                                                    color: AppColors.neutral_01,
                                                  ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              const Spacer(),
                              FavoriteButton(
                                isFavorite: product.favorite,
                                // productId: product.id,
                                // onRequestSuccess:
                                //     favoriteRequestSuccessCallback,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _ProductDetails(product: product, detailedView: _detailedView),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;
  final bool detailedView;
  const _ProductDetails({required this.product, required this.detailedView});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SecondaryAppButton(
          text: localization(context).addToCart,
          disableTextScaling: true,
          height: 40,
          onPressed: () => showNotImplementedDialog(context),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 12,
            bottom: 12,
            left: getValueWithDirection(context, 12.0, 0.0),
            right: getValueWithDirection(context, 0.0, 12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingBarIndicator(
                // Round to closest 0.5 step
                rating: (product.rating * 2).round() / 2,
                itemBuilder:
                    (context, index) => SvgPicture.asset(
                      AppIcons.rating,
                      theme: SvgTheme(currentColor: AppColors.neutral_05),
                    ),
                itemCount: 5,
                itemSize: 16,
                unratedColor: AppColors.neutral_03,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1),
              ),
              const SizedBox(height: 4),
              Text(
                product.name,
                style: AppTextStyles.body2Semi.copyWith(
                  color: AppColors.neutral_07,
                ),
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Builder(
                    builder: (context) {
                      final currencyCode = getCurrencySymbol(
                        product.currencyCode,
                      );
                      final productPrice =
                          product.discount == null
                              // No discounts? full price
                              ? product.price
                              // Discounted price
                              : product.price -
                                  (product.price * product.discount! / 100);
                      return Flexible(
                        child: Text(
                          '$currencyCode${productPrice.toStringAsFixed(2)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.caption1Semi.copyWith(
                            color: AppColors.neutral_07,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  if (product.discount != null)
                    Flexible(
                      child: Text(
                        '${getCurrencySymbol(product.currencyCode)}${product.price.toStringAsFixed(2)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption1Semi.copyWith(
                          color: AppColors.neutral_04,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                ],
              ),
              if (detailedView)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Flexible(
                      child: Text(
                        product.description,
                        style: AppTextStyles.caption2.copyWith(
                          color: AppColors.neutral_04,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
