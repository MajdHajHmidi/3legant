import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/duration_extension.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/app_expanded_tile.dart';
import 'package:e_commerce/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductAdditionalInformation extends StatelessWidget {
  const ProductAdditionalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      buildWhen: (_, state) => state is ProductDetailsInfoExpandedState,
      builder: (context, state) {
        final cubit = context.read<ProductDetailsCubit>();

        return SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: AppExpandedTile(
                isExpanded: cubit.isProductInfoExpanded,
                text: localization(context).additionalInformation,
                onTap: cubit.toggleProductInfoExpansion,
              ),
            ),
            SliverToBoxAdapter(
              child: AppExpandedContent(
                duration: 250.ms,
                isExpanded: cubit.isProductInfoExpanded,
                curve: Curves.easeInOut,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Builder(
                    builder: (context) {
                      final model = cubit.productDetailsModel.data!;
                      final packageWidth =
                          '${localization(context).width}: ${model.packagingWidth}';
                      final packageHeight =
                          '${localization(context).height}: ${model.packagingHeight}';
                      final packageLength =
                          '${localization(context).length}: ${model.packagingLength}';
                      final packageWeight =
                          '${localization(context).weight}: ${model.packagingWeight}';
                      final packageCount =
                          '${localization(context).packagesCount}: ${model.packagingCount}';
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoSection(
                            title: localization(context).details,
                            content: model.details,
                          ),
                          SizedBox(height: 16),
                          _buildInfoSection(
                            title: localization(context).packaging,
                            content:
                                '$packageWidth $packageHeight $packageLength\n$packageWeight\n$packageCount',
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildInfoSection({required String title, required String content}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: AppTextStyles.caption1Semi.copyWith(color: AppColors.neutral_04),
      ),
      SizedBox(height: 4),
      Text(
        content,
        style: AppTextStyles.caption2.copyWith(color: AppColors.neutral_07),
      ),
    ],
  );
}
