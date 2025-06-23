import 'package:e_commerce/core/widgets/app_divider.dart';
import 'package:e_commerce/core/widgets/sliver_util.dart';
import 'package:e_commerce/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:e_commerce/product_details/presentation/widgets/product_add_to_cart.dart';
import 'package:e_commerce/product_details/presentation/widgets/product_additional_information.dart';
import 'package:e_commerce/product_details/presentation/widgets/product_category.dart';
import 'package:e_commerce/product_details/presentation/widgets/product_color.dart';
import 'package:e_commerce/product_details/presentation/widgets/product_discount_expiration.dart';
import 'package:e_commerce/product_details/presentation/widgets/product_image_carousel.dart';
import 'package:e_commerce/product_details/presentation/widgets/product_measurements.dart';
import 'package:e_commerce/product_details/presentation/widgets/product_overview.dart';
import 'package:e_commerce/product_details/presentation/widgets/product_reviews.dart';
import 'package:e_commerce/product_details/presentation/widgets/product_submit_review.dart';
import 'package:e_commerce/product_details/presentation/widgets/similar_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsDataView extends StatelessWidget {
  const ProductDetailsDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    final model = cubit.productDetailsModel.data!;

    if (model.discountEndDate != null) {
      cubit.startDiscountExpirationTimer(model.discountEndDate!);
    }

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverIndent(height: 16),
              SliverToBoxAdapter(child: ProductImageCarousel(model: model)),
              SliverIndent(height: 32),
              SliverToBoxAdapter(child: ProductOverview(model: model)),
              if (model.discount != null) ...[
                _buildDivider(),
                SliverToBoxAdapter(
                  child: ProductDiscountExpiration(
                    model: model,
                    durationStream: cubit.countdownStream!,
                  ),
                ),
              ],
              _buildDivider(),
              SliverToBoxAdapter(child: ProductMeasurements(model: model)),
              ...[
                SliverIndent(height: 24),
                SliverToBoxAdapter(
                  child: ProductColor(
                    model: model,
                    selectedColorIndex: cubit.selectedColorIndex,
                    changeSelectedColorHandler: cubit.changeSelectedColor,
                  ),
                ),
              ],
              _buildDivider(),
              SliverToBoxAdapter(child: ProductCategory(model: model)),
              SliverIndent(height: 24),
              BlocProvider.value(
                value: cubit,
                child: ProductAdditionalInformation(),
              ),
              SliverIndent(height: 16),
              BlocProvider.value(value: cubit, child: ProductReviews()),
              SliverIndent(height: 32),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SimilarProducts(products: model.similarProducts!),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverIndent(height: 64),
              SliverToBoxAdapter(
                child: BlocProvider.value(
                  value: cubit,
                  child: ProductSubmitReview(),
                ),
              ),
              SliverIndent(height: 80),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: BlocProvider.value(value: cubit, child: ProductAddToCart()),
          ),
        ),
        SliverIndent(height: 16),
      ],
    );
  }
}

Widget _buildDivider() {
  return SliverPadding(
    padding: const EdgeInsets.only(top: 24, bottom: 24),
    sliver: SliverToBoxAdapter(child: AppDivider()),
  );
}
