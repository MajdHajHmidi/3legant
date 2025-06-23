import 'package:e_commerce/core/constants/app_assets.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/app_circular_progress_indicator.dart';
import 'package:e_commerce/core/widgets/app_rating_bar.dart';
import 'package:e_commerce/core/widgets/app_textfield.dart';
import 'package:e_commerce/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductSubmitReview extends StatelessWidget {
  const ProductSubmitReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localization(context).rateThisProduct,
          style: AppTextStyles.caption2.copyWith(color: AppColors.neutral_05),
        ),
        SizedBox(height: 8),
        BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          buildWhen: (_, state) => state is ProductDetailsRatingChangedState,
          builder: (context, state) {
            final cubit = context.read<ProductDetailsCubit>();

            return AppRatingBar.interactive(
              rating: cubit.rating,
              onUpdate: cubit.changeRating,
            );
          },
        ),
        SizedBox(height: 36),
        BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          buildWhen:
              (_, state) => state is ProductDetailsReviewDataChangedState,
          builder: (context, state) {
            final cubit = context.read<ProductDetailsCubit>();

            return AppTextFormField.outlineBorder(
              controller: cubit.userReviewTextController,
              hint: localization(context).shareYourThoughts,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 24,
              ),
              suffixIcon: Container(
                width: 72,
                height: 72,
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child:
                    cubit.userReviewSubmitModel.isLoading
                        ? AppCircularProgressIndicator()
                        : SvgPicture.asset(AppIcons.arrowRightCircle),
              ),
              onSuffixIconPressed: cubit.submitReview,
              onFieldSubmitted: (value) => cubit.submitReview(),
            );
          },
        ),
      ],
    );
  }
}
