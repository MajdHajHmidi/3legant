import 'package:e_commerce/core/constants/app_constants.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/duration_extension.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_circular_progress_indicator.dart';
import 'package:e_commerce/core/widgets/app_divider.dart';
import 'package:e_commerce/core/widgets/app_expanded_tile.dart';
import 'package:e_commerce/core/widgets/app_image.dart';
import 'package:e_commerce/core/widgets/app_rating_bar.dart';
import 'package:e_commerce/core/widgets/async_retry.dart';
import 'package:e_commerce/core/widgets/sliver_util.dart';
import 'package:e_commerce/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_expandable/sliver_expandable.dart';

class ProductReviews extends StatelessWidget {
  const ProductReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      buildWhen:
          (_, state) =>
              state is ProductReviewsDataChangedState ||
              state is ProductDetailsReviewsExpandedState ||
              state is ProductDetailsDataChangedState,
      builder: (context, state) {
        final cubit = context.read<ProductDetailsCubit>();

        return SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: AppExpandedTile(
                isExpanded: cubit.isProductReviewsExpanded,
                text:
                    '${localization(context).reviews} (${cubit.productDetailsModel.data!.reviewsCount ?? 0})',
                onTap: cubit.toggleProductReviewsExpansion,
              ),
            ),
            AnimatedSliverExpandable(
              expanded: cubit.isProductReviewsExpanded,
              duration: 350.ms,
              curve: Curves.easeInOut,
              sliver: AsyncValueBuilder(
                value: cubit.productReviewsModel,
                loading:
                    (context) => const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 150,
                        child: Center(child: AppCircularProgressIndicator()),
                      ),
                    ),
                error:
                    (context, error) => SliverToBoxAdapter(
                      child: SizedBox(
                        height: 150,
                        child: Center(
                          child: AsyncRetryWidget(
                            message: localization(context).rpcError(error.code),
                            onPressed:
                                () => cubit.getProductReviews(
                                  productId: cubit.productId,
                                  pageIndex:
                                      AppConstants.appStartingPaginationIndex,
                                ),
                          ),
                        ),
                      ),
                    ),
                data: (context, data) {
                  final reviewsWithComments =
                      data.reviews
                          .where((review) => review.comment != null)
                          .toList();

                  // if (!cubit.isProductReviewsExpanded) {
                  //   return SliverToBoxAdapter(child: const SizedBox.shrink());
                  // }

                  return SliverMainAxisGroup(
                    slivers: [
                      SliverIndent(height: 16),
                      SliverList.separated(
                        itemCount: reviewsWithComments.length,
                        itemBuilder: (context, index) {
                          final review = reviewsWithComments[index];

                          return _ProductReviewTile(
                            avatarUrl:
                                review.userAvatar ??
                                AppConstants.userAvatarPlaceholderImageUrl,
                            name: review.userName,
                            rating: review.rating,
                            comment: review.comment!,
                          );
                        },
                        separatorBuilder:
                            (_, _) => Column(
                              children: [
                                AppDivider(),
                                const SizedBox(height: 24),
                              ],
                            ),
                      ),

                      // This is the "Show More" button
                      if (cubit
                              .productReviewsModel
                              .data!
                              .paginationInfo
                              .currentPage <
                          cubit
                              .productReviewsModel
                              .data!
                              .paginationInfo
                              .totalPages)
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          sliver: SliverToBoxAdapter(
                            child: Align(
                              child: AppRoundedButton.outlined(
                                width:
                                    160 *
                                    MediaQuery.textScalerOf(context).scale(1),
                                text: localization(context).showMore,
                                loading:
                                    cubit.productReviewsModel.isLoadingPage,
                                onPressed:
                                    () => cubit.getProductReviews(
                                      productId: cubit.productId,
                                      pageIndex:
                                          cubit
                                              .productReviewsModel
                                              .data!
                                              .paginationInfo
                                              .currentPage +
                                          1,
                                    ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProductReviewTile extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final double rating;
  final String comment;
  const _ProductReviewTile({
    required this.avatarUrl,
    required this.name,
    required this.rating,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              child: AppNetworkImage(
                imageUrl: avatarUrl,
                borderRadius: BorderRadius.circular(360),
                width: 72,
                height: 72,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    style: AppTextStyles.body1Semi.copyWith(
                      color: AppColors.neutral_06,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppRatingBar(rating: rating),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          comment,
          style: AppTextStyles.body2.copyWith(color: AppColors.neutral_05),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
