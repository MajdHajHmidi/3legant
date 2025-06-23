import 'package:e_commerce/product_details/models/product_details_model.dart';

import '../../../core/navigation/router.dart';
import '../../../core/styles/colors.dart';
import '../../../core/widgets/product_tile.dart';
import 'package:go_router/go_router.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/util/localization.dart';
import '../../../core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import '../../../core/models/product.dart' as app_product;

class SimilarProducts extends StatelessWidget {
  final List<ProductDetailsModel> products;
  const SimilarProducts({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization(context).youMightAlsoLike,
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

                return ProductTile(
                  product: app_product.Product(
                    id: product.id,
                    productNew: product.isNew,
                    name: product.name,
                    price: product.price,
                    rating: product.rating,
                    details: product.details,
                    discount: product.discount,
                    favorite: product.isFavorite,
                    imagesUrl: product.imagesUrl,
                    description: product.description,
                    measurements: product.measurements,
                    currencyCode: product.currencyCode,
                    discountEndDate: product.discountEndDate,
                  ),
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
            onPressed: () => context.goNamed(AppRoutes.shop.name),
          ),
        ),
      ],
    );
  }
}
