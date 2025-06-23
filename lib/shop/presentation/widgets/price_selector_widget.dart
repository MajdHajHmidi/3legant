import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/util/dependency_injection.dart';
import '../../../core/util/localization.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_dropdown.dart';
import '../../models/product_filters.dart';
import '../../models/shop_data_model.dart';
import '../cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceSelectorWidget extends StatelessWidget {
  const PriceSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      bloc: serviceLocator<ShopCubit>(),
      builder: (context, state) {
        final cubit = serviceLocator<ShopCubit>();
        final currencySymbol = getCurrencySymbol(
          cubit.shopDataModel.data!.currencyCode,
        );

        late PriceRange totalPriceRange;
        if (cubit.filters.categoryId.isEmpty) {
          totalPriceRange = cubit.shopDataModel.data!.totalPriceRange;
        } else {
          totalPriceRange =
              cubit.shopDataModel.data!.categories
                  .firstWhere(
                    (category) => category.id == cubit.filters.categoryId,
                  )
                  .priceRange;
        }

        RangeValues selectedPriceRange = RangeValues(
          cubit.filters.minPrice ?? totalPriceRange.minPrice,
          cubit.filters.maxPrice ?? totalPriceRange.maxPrice,
        );

        return StatefulBuilder(
          builder: (context, setState) {
            return CustomAppDropdownButton(
              text: getPriceRangeText(
                context: context,
                currencySymbol: currencySymbol,
                minPrice: selectedPriceRange.start.floorToDouble(),
                maxPrice: selectedPriceRange.end.ceilToDouble(),
                noSelectedPrice:
                    selectedPriceRange.start == totalPriceRange.minPrice &&
                    selectedPriceRange.end == totalPriceRange.maxPrice,
              ),
              menuBuilder: (context, width, controller) {
                return Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(40),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: const Offset(5, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        child: SliderTheme(
                          data: SliderThemeData(
                            rangeThumbShape: RoundRangeSliderThumbShape(
                              enabledThumbRadius: 8,
                            ),
                            trackHeight: 24,
                            thumbColor: AppColors.neutral_01,
                            activeTrackColor: AppColors.neutral_07,
                            inactiveTrackColor: AppColors.neutral_03,
                            overlayShape: SliderComponentShape.noOverlay,
                          ),
                          child: RangeSlider(
                            values: selectedPriceRange,
                            min: totalPriceRange.minPrice,
                            max: totalPriceRange.maxPrice,
                            onChanged: (newRange) {
                              setState(() {
                                selectedPriceRange = newRange;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${totalPriceRange.minPrice.floor()}$currencySymbol',
                                  style: AppTextStyles.caption1.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.neutral_04,
                                  ),
                                ),

                                Text(
                                  '${totalPriceRange.maxPrice.ceil()}$currencySymbol',
                                  style: AppTextStyles.caption1.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.neutral_04,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SecondaryAppButton(
                                    text: localization(context).applyFilter,
                                    width: null,
                                    disableTextScaling: true,
                                    height: 40,
                                    onPressed: () {
                                      controller.hide();
                                      cubit.applyFilters(
                                        cubit.filters.copyWith(
                                          query: cubit.queryTextController.text,
                                          minPrice: selectedPriceRange.start,
                                          maxPrice: selectedPriceRange.end,
                                          page:
                                              AppConstants
                                                  .appStartingPaginationIndex,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 2,
                                  child: SecondaryAppButton.outlined(
                                    text: localization(context).reset,
                                    width: null,
                                    disableTextScaling: true,
                                    height: 40,
                                    onPressed: () {
                                      controller.hide();
                                      cubit.applyFilters(
                                        ProductFilters(
                                          query: cubit.queryTextController.text,
                                          categoryId: cubit.filters.categoryId,
                                          minPrice: null,
                                          maxPrice: null,
                                          page:
                                              AppConstants
                                                  .appStartingPaginationIndex,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

String getPriceRangeText({
  required BuildContext context,
  required String currencySymbol,
  required double minPrice,
  required double maxPrice,
  bool noSelectedPrice = false,
}) {
  if (noSelectedPrice) {
    return localization(context).allPrices;
  }

  return '$currencySymbol ${minPrice.toStringAsFixed(0)}  -  ${maxPrice.toStringAsFixed(0)}';
}
