import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/util/localization.dart';
import '../../../core/util/testing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_image.dart';
import '../../../favorite/presentation/widgets/favorite_button.dart';
import '../cubit/home_cubit.dart';
import '../../models/home_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeNewProducts extends StatelessWidget {
  final List<Product> products;
  const HomeNewProducts({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization(context).homeNewArrivals,
                style: AppTextStyles.headline5.copyWith(
                  color: AppColors.neutral_07,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(products.length, (index) {
                final product = products[index];

                return _ProductTile(
                  product: product,
                  index: index,
                  productsLength: products.length,
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: AppTextButton(
            text: localization(context).moreProducts,
            onPressed: () => showNotImplementedDialog(context),
          ),
        ),
      ],
    );
  }
}

class _ProductTile extends StatelessWidget {
  final Product product;
  final int index;
  final int productsLength;
  const _ProductTile({
    required this.product,
    required this.index,
    required this.productsLength,
  });

  // For LTR locales, the first element has a 32px left padding, while RTL only 8, and the opposite for right padding
  // Same goes for the last element
  EdgeInsets getItemPadding(BuildContext context) {
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

    return const EdgeInsets.only(right: 8, left: 8);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getItemPadding(context),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => showNotImplementedDialog(context),
          child: SizedBox(
            width: 230,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 310,
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
                                          style: AppTextStyles.hairline1
                                              .copyWith(
                                                color: AppColors.neutral_07,
                                              ),
                                        ),
                                      ),
                                    ),
                                    if (product.discount != null)
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
                              BlocBuilder<HomeCubit, HomeState>(
                                buildWhen:
                                    (_, state) =>
                                        state is HomeFavoriteProductToggleState,
                                builder: (context, state) {
                                  return FavoriteButton(
                                    isFavorite: product.favorite,
                                    productId: product.id,
                                    onRequestSuccess:
                                        () => context
                                            .read<HomeCubit>()
                                            .toggleProductFavorite(index),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _ProductDetails(product),
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
  const _ProductDetails(this.product);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SecondayAppButton(
          text: localization(context).addToCart,
          disableTextScaling: true,
          height: 40,
          onPressed: () => showNotImplementedDialog(context),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 12,
            left: getValueWithDirection(context, 12.0, 0.0),
            right: getValueWithDirection(context, 0.0, 12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
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
                        product.currencyCode.name,
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
                        '${getCurrencySymbol(product.currencyCode.name)}${product.price.toStringAsFixed(2)}',
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
            ],
          ),
        ),
      ],
    );
  }
}
