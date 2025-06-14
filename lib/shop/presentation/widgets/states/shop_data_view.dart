import 'package:flutter/material.dart';
import 'package:flutter_async_value/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/util/dependency_injection.dart';
import '../../../../core/util/localization.dart';
import '../../../../core/widgets/async_retry.dart';
import '../../../../core/widgets/sliver.dart';
import '../../cubit/shop_cubit.dart';
import '../products_filters_widget.dart';
import '../products_loading_widget.dart';
import '../products_widget.dart';
import '../shop_header.dart';

class ShopDataView extends StatelessWidget {
  const ShopDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = serviceLocator<ShopCubit>().shopDataModel.data!;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.center,
                  child: ShopHeader(metadata: model.metadata),
                ),
              ),
              const SliverSizedBox(height: 16),
              SliverToBoxAdapter(child: ProductsFiltersWidget()),
              const SliverSizedBox(height: 24),
              BlocBuilder<ShopCubit, ShopState>(
                bloc: serviceLocator<ShopCubit>(),
                builder: (context, state) {
                  final cubit = serviceLocator<ShopCubit>();

                  return AsyncValueBuilder(
                    value: cubit.filteredProducts,
                    loading: (context) => ProductsLoadingWidget(),

                    error:
                        (context, error) => SliverFillRemaining(
                          hasScrollBody: false,
                          child: SizedBox(
                            height: 150,
                            child: Center(
                              child: AsyncRetryWidget(
                                message: localization(
                                  context,
                                ).rpcError(error.code),
                                onPressed: () => cubit.getFilteredProducts(),
                              ),
                            ),
                          ),
                        ),
                    data: (context, data) {
                      if (data.products.isEmpty) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: SizedBox(
                            height: 150,
                            child: Center(
                              child: Text(
                                localization(context).noProductsFound,
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.neutral_04,
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      return ProductsWidget(
                        model: data,
                        layout: cubit.productsViewLayout,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
