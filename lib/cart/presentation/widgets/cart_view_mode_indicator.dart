import 'package:e_commerce/cart/application/cart_controller.dart';
import 'package:e_commerce/cart/presentation/cubit/cart_view_mode_cubit.dart';
import 'package:e_commerce/cart/presentation/widgets/cart_view_mode_indicator_tile.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartViewModeIndicator extends StatelessWidget {
  const CartViewModeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    // When UI rebuilds, provide the additional offset needed to
    // view the part of the next child (screen orientation,
    // screen resize on desktop/website, etc.)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartController>().changeIndicatorPage(
        context: context,
        viewMode: context.read<CartViewModeCubit>().state,
      );
    });

    return SizedBox(
      height: CartViewModeIndicatorTile.widgetHeight(context),
      child: BlocBuilder<CartViewModeCubit, CartViewMode>(
        builder: (context, state) {
          final indicatorTexts = [
            localization(context).shoppingCart,
            localization(context).checkoutDetails,
            localization(context).orderComplete,
          ];

          return PageView(
            controller:
                context.read<CartController>().cartIndicatorPageController,
            physics: const NeverScrollableScrollPhysics(),
            pageSnapping: false,
            children: [
              ...List<Widget>.generate(3, (index) {
                final isSelected = state.index == index;
                return Container(
                  decoration: BoxDecoration(
                    border:
                        isSelected
                            ? Border(
                              bottom: BorderSide(
                                color: AppColors.neutral_07,
                                width: 2,
                              ),
                            )
                            : null,
                  ),
                  child: CartViewModeIndicatorTile(
                    index: index,
                    isSelected: isSelected,
                    text: indicatorTexts[index],
                  ),
                );
              }),
              // Additional child to align the last element to the start
              const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
