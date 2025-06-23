import '../../../core/navigation/router.dart';
import '../../../core/styles/colors.dart';
import '../../../core/widgets/product_tile.dart';
import 'package:go_router/go_router.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/util/localization.dart';
import '../../../core/widgets/app_button.dart';
import '../cubit/home_cubit.dart';
import '../../models/home_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/product.dart' as app_product;

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

                return BlocBuilder<HomeCubit, HomeState>(
                  buildWhen:
                      (_, state) => state is HomeFavoriteProductToggleState,
                  builder: (context, state) {
                    return ProductTile(
                      product: app_product.Product(
                        id: product.id,
                        productNew: product.productNew,
                        name: product.name,
                        price: product.price,
                        rating: product.rating,
                        details: product.details,
                        discount: product.discount,
                        favorite: product.favorite,
                        imagesUrl: product.imagesUrl,
                        description: product.description,
                        measurements: product.measurements,
                        currencyCode: product.currencyCode,
                        discountEndDate: product.discountEndDate,
                      ),
                      index: index,
                      productsLength: products.length,
                      // favoriteRequestSuccessCallback:
                      //     () => context.read<HomeCubit>().toggleProductFavorite(
                      //       index,
                      //     ),
                    );
                  },
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
