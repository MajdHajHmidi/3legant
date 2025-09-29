import 'package:e_commerce/cart/models/cart_screen_data_model.dart';
import 'package:e_commerce/cart/presentation/cubit/cart_screen_data_cubit.dart';
import 'package:e_commerce/cart/presentation/widgets/states/cart_screen_data_view.dart';
import 'package:e_commerce/cart/presentation/widgets/states/cart_screen_error_view.dart';
import 'package:e_commerce/cart/presentation/widgets/states/cart_screen_loading_view.dart';
import 'package:e_commerce/core/navigation/router.dart';
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/custom_app_bar.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, _) {
        // Close the keybaord if already opened
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          text: localization(context).cart,
          leadingIconAction: () {
            // Close the keybaord if already opened
            FocusScope.of(context).unfocus();
            context.goNamed(AppRoutes.home.name);
          },
        ),
        body: BlocBuilder<
          CartScreenDataCubit,
          AsyncValue<CartScreenDataModel, AppFailure>
        >(
          builder: (context, state) {
            return AsyncValueBuilder(
              value: state,
              loading: (_) => CartScreenLoadingView(),
              data: (context, data) => CartScreenDataView(),
              error: (_, error) => CartScreenErrorView(failure: error),
            );
          },
        ),
      ),
    );
  }
}
