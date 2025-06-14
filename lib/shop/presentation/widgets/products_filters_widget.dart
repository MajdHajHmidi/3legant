import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/cubit/app_cubit.dart';
import '../../../core/navigation/router.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/util/dependency_injection.dart';
import '../../../core/util/duration_extension.dart';
import '../../../core/util/localization.dart';
import '../../../core/util/text.dart';
import '../../../core/widgets/app_dropdown.dart';
import '../../../core/widgets/app_textfield.dart';
import '../../models/product_filters.dart';
import '../../models/shop_data_model.dart';
import '../cubit/shop_cubit.dart';
import 'price_selector_widget.dart';
import 'products_layout_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProductsFiltersWidget extends StatefulWidget {
  const ProductsFiltersWidget({super.key});

  @override
  State<ProductsFiltersWidget> createState() => _ProductsFiltersWidgetState();
}

class _ProductsFiltersWidgetState extends State<ProductsFiltersWidget> {
  FocusNode searchFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    final appCubit = serviceLocator<AppCubit>();

    // Run explicitly on first launch (Lisetener won't be loaded yet)
    if (appCubit.shopScreenSeachAutoFocus) {
      _requestFocusOnSearchField();
    }

    final router = serviceLocator<GoRouter>();
    // Listen to router changes

    router.routerDelegate.addListener(() {
      // Check when current screen is opened
      final currentLocation = router.state.name;
      if (currentLocation != AppRoutes.shop.name) return;

      final triggerFocus = serviceLocator<AppCubit>().shopScreenSeachAutoFocus;

      if (!triggerFocus) return;

      _requestFocusOnSearchField();
    });
  }

  void _requestFocusOnSearchField() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ensure the widget is still in the tree before requesting focus.
      if (mounted) {
        searchFieldFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    searchFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      bloc: serviceLocator<ShopCubit>(),
      builder: (context, state) {
        final cubit = serviceLocator<ShopCubit>();
        final filters = cubit.filters;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(context: context, focusNode: searchFieldFocusNode),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _buildFiltersButtons(
                filters: filters,
                productsViewLayout: cubit.productsViewLayout,
                changeProductsViewLayout: cubit.changeProductsViewLayout,
                toggleProductsFiltersExpandsion:
                    cubit.toggleProductsFiltersExpansion,
              ),
            ),
            AnimatedSize(
              duration: 250.ms,
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child:
                  cubit.isProductsFiltersExpanded
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            localization(context).categories.toUpperCase(),
                            style: AppTextStyles.body2Semi.copyWith(
                              color: AppColors.neutral_04,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildCategoryDropdown(
                            context: context,
                            filters: filters,
                            categories: cubit.shopDataModel.data!.categories,
                            categorySelectionCallback:
                                (value) => cubit.applyFilters(
                                  ProductFilters(
                                    query: cubit.queryTextController.text,
                                    categoryId: value ?? '',
                                    minPrice: null,
                                    maxPrice: null,
                                    page:
                                        AppConstants
                                            .supabaseStartingPaginationIndex,
                                  ),
                                ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            localization(context).price.toUpperCase(),
                            style: AppTextStyles.body2Semi.copyWith(
                              color: AppColors.neutral_04,
                            ),
                          ),
                          const SizedBox(height: 8),
                          BlocProvider.value(
                            value: cubit,
                            child: PriceSelectorWidget(),
                          ),
                        ],
                      )
                      : const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildFiltersButtons({
  required ProductsViewLayout productsViewLayout,
  required ProductFilters filters,
  required void Function() toggleProductsFiltersExpandsion,
  required void Function(ProductsViewLayout) changeProductsViewLayout,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final tileWidth =
          (constraints.maxWidth / 2) -
          12 // Spacing
          ;
      final filterTextHeight =
          calculateTextSize(
            context: context,
            text: localization(context).filters,
            style: AppTextStyles.body2Semi,
            maxWidth:
                tileWidth -
                8 - // Space between Icon and text
                (24 * MediaQuery.textScalerOf(context).scale(1)),
          ).height;
      final tileHeight =
          filterTextHeight +
          16 // Vertical padding
          ;
      return Stack(
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: toggleProductsFiltersExpandsion,
                  child: Ink(
                    height: tileHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.neutral_02,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppIcons.filter,
                          width: 24 * MediaQuery.textScalerOf(context).scale(1),
                          theme: SvgTheme(currentColor: AppColors.neutral_07),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            localization(context).filters,
                            maxLines: 1,
                            style: AppTextStyles.body2Semi.copyWith(
                              color: AppColors.neutral_07,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ProductsLayoutSwitch(
                  height: tileHeight,
                  layout: productsViewLayout,
                  layoutToggleCallback: changeProductsViewLayout,
                ),
              ),
            ],
          ),
          Builder(
            builder: (context) {
              if (filters.categoryId.isEmpty &&
                  filters.minPrice == null &&
                  filters.maxPrice == null) {
                return SizedBox.shrink();
              }

              return Positioned(
                top: -1.0,
                left: getValueWithDirection(context, -1.0, null),
                right: getValueWithDirection(context, null, -1.0),
                child: Ink(
                  width: 8,
                  height: 8,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.neutral_07,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}

Widget _buildCategoryDropdown({
  required BuildContext context,
  required ProductFilters filters,
  required List<Category> categories,
  required void Function(String? value) categorySelectionCallback,
}) {
  return AppDropdownButton<String>(
    value: filters.categoryId,
    width: double.infinity,
    items:
        {}..addEntries(
          categories.map((category) => MapEntry(category.id, category.name)),
        ),
    defaultValue: '',
    defaultText: localization(context).allCategories,
    onChanged: categorySelectionCallback,
  );
}

Widget _buildTextField({
  required BuildContext context,
  required FocusNode? focusNode,
}) {
  final cubit = serviceLocator<ShopCubit>();
  return AppTextFormField(
    controller: serviceLocator<ShopCubit>().queryTextController,
    hint: localization(context).productQueryHint,
    textInputAction: TextInputAction.search,
    focusNode: focusNode,
    onFieldSubmitted:
        (value) => cubit.applyFilters(
          cubit.filters.copyWith(
            page: AppConstants.supabaseStartingPaginationIndex,
            query: value,
          ),
        ),
  );
}
