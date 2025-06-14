import '../../../core/navigation/router.dart';
import '../../../core/util/app_snackbar.dart';
import '../../../core/util/dependency_injection.dart';
import '../../../core/util/localization.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../cubit/shop_cubit.dart';
import '../widgets/states/shop_data_view.dart';
import '../widgets/states/shop_error_view.dart';
import '../widgets/states/shop_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = serviceLocator<ShopCubit>();
    // Request data if data hasn't been requested at all
    // Note: This method isn't called in the cubit constructor
    // because filters can be externally applied, see: app_cubit.dart
    if (cubit.filteredProducts.isInitial) {
      cubit.getFilteredProducts();
    }

    return Scaffold(
      appBar: CustomAppBar(
        text: localization(context).navShop,
        leadingIconAction: () {
          // Close the keybaord if already opened
          FocusScope.of(context).unfocus();
          context.goNamed(AppRoutes.home.name);
        },
      ),
      body: BlocConsumer<ShopCubit, ShopState>(
        bloc: cubit,
        listenWhen:
            (_, state) => state is ShopFilteredProductsPaginationFailureState,
        listener: (context, state) {
          if (state is ShopFilteredProductsPaginationFailureState) {
            showErrorSnackBar(
              context,
              localization(context).rpcError(state.failure.code),
            );
          }
        },
        builder: (context, state) {
          final cubit = serviceLocator<ShopCubit>();

          return AsyncValueBuilder(
            value: cubit.shopDataModel,
            loading: (context) => ShopLoadingView(),
            data: (context, data) => ShopDataView(),
            error: (context, error) => ShopErrorView(),
          );
        },
      ),
    );
  }
}
