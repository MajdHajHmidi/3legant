import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import 'package:e_commerce/core/navigation/router.dart';
import 'package:e_commerce/core/widgets/app_rating_bar.dart';
import 'package:go_router/go_router.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../util/localization.dart';
import '../util/testing.dart';
import 'app_button.dart';
import 'app_image.dart';
import '../../favorite/presentation/widgets/favorite_button.dart';
import 'package:flutter/material.dart';


import '../models/product.dart';

enum _ProductTileViewMode { defaultView, detailed }

class ProductTile extends StatelessWidget {
  final Product product;
  final int index;
  final int productsLength;

  /// Indicates that the product tiles will be placed in a
  /// horizontal scroll view, which adds a complexity of
  /// calculating padding on the left and right for first and
  /// last elements
  final bool horizontalMode;

  final _ProductTileViewMode _productTileView;

  /// The callback that runs when the favorite is successfully toggled
  /// This runs after the data been changed on the server side
  /// It's useful for changing the `favorite` propery in the model to sync states
  final void Function()? favoriteRequestSuccessCallback;
  const ProductTile({
    super.key,
    required this.product,
    required this.index,
    required this.productsLength,
    this.horizontalMode = true,
    this.favoriteRequestSuccessCallback,
  }) : _productTileView = _ProductTileViewMode.defaultView;

  const ProductTile.detailed({
    super.key,
    required this.product,
    required this.index,
    required this.productsLength,
    this.horizontalMode = true,
    this.favoriteRequestSuccessCallback,
  }) : _productTileView = _ProductTileViewMode.detailed;

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
          onTap:
              () => context.pushNamed(
                AppRoutes.productDetails.name,
                pathParameters: {'product_id': product.id},
                extra: {'product_name': product.name},
              ),
          child: SizedBox(
            width: horizontalMode ? 230 : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height:
                        _productTileView == _ProductTileViewMode.detailed
                            ? 400
                            : 310,
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
                          child: ProductTileOverlay(product: product),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _ProductDetails(
                  product: product,
                  productTileView: _productTileView,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductTileOverlay extends StatelessWidget {
  final Product product;
  const ProductTileOverlay({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.productNew || product.discount != null)
          Container(
            padding: EdgeInsets.symmetric(
              vertical: product.discount != null ? 8 : 5,
              horizontal: product.discount != null ? 10 : 5,
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
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        localization(context).newCapitalized,
                        textScaler: TextScaler.linear(1),
                        style: AppTextStyles.hairline1.copyWith(
                          color: AppColors.neutral_07,
                        ),
                      ),
                    ),
                  ),
                if (product.discount != null && product.productNew)
                  const SizedBox(height: 8),
                if (product.discount != null)
                  Container(
                    width: 70,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.green,
                    ),
                    child: Center(
                      child: Text(
                        '-${product.discount!.toInt()}%',
                        textScaler: TextScaler.linear(1),
                        style: AppTextStyles.hairline1.copyWith(
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
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;
  final _ProductTileViewMode productTileView;
  const _ProductDetails({required this.product, required this.productTileView});

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
              AppRatingBar(rating: product.rating),
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
                      final currencySymbol = getCurrencySymbol(
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
                          '$currencySymbol${productPrice.toStringAsFixed(2)}',
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
              if (productTileView == _ProductTileViewMode.detailed)
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
