import 'package:e_commerce/cart/presentation/cubit/cart_view_mode_cubit.dart';
import 'package:e_commerce/core/util/duration_extension.dart';
import 'package:flutter/material.dart';

class CartController {
  final cartIndicatorPageController = PageController();
  final CartViewModeCubit cartViewModeCubit;

  CartController(BuildContext context, {required this.cartViewModeCubit}) {
    // When view mode changes, trigger page view animation
    cartViewModeCubit.stream.listen((viewMode) {
      changeIndicatorPage(context: context, viewMode: viewMode);
    });
  }

  void changeIndicatorPage({
    required BuildContext context,
    required CartViewMode viewMode,
  }) {
    final pageWidth = cartIndicatorPageController.position.viewportDimension;
    final defaultOffset = pageWidth * viewMode.index;
    final additionalOffset =
        40 *
        MediaQuery.textScalerOf(
          context,
        ).scale(1); // 40 is the circle diameter (check UI)

    cartIndicatorPageController.animateTo(
      defaultOffset + additionalOffset,
      duration: 500.ms,
      curve: Curves.fastOutSlowIn,
    );
  }

  void dispose() {
    cartIndicatorPageController.dispose();
  }
}
