import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/util/testing.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductAddToCart extends StatelessWidget {
  const ProductAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);

    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      buildWhen: (_, state) => state is ProductDetailsCartQuantityChangedState,
      builder: (context, state) {
        final cubit = context.read<ProductDetailsCubit>();

        return SizedBox(
          height: 40 * MediaQuery.textScalerOf(context).scale(1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildQuantitySelectorButton(
                textDirection: textDirection,
                onTap: cubit.decrementQuantityInCart,
                buttonAlignment: Alignment.centerLeft,
              ),
              Container(
                color: AppColors.neutral_02,
                alignment: Alignment.center,
                child: Text(
                  '${cubit.quantityInCart}',
                  style: AppTextStyles.caption2Semi.copyWith(
                    color: AppColors.neutral_07,
                  ),
                ),
              ),
              _buildQuantitySelectorButton(
                textDirection: textDirection,
                onTap: cubit.incrementQuantityInCart,
                buttonAlignment: Alignment.centerRight,
              ),
              SizedBox(width: 16),
              Expanded(
                child: SecondaryAppButton(
                  text: localization(context).addToCart,
                  onPressed: () => showNotImplementedDialog(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

BorderRadius _getBorderRadius({
  required TextDirection textDirection,
  required AlignmentGeometry buttonAlignment,
}) {
  final roundedRadius = Radius.circular(8);
  final notRoundedRadius = Radius.zero;

  if (textDirection == TextDirection.ltr) {
    return BorderRadius.only(
      bottomLeft:
          buttonAlignment == Alignment.centerLeft
              ? roundedRadius
              : notRoundedRadius,
      topLeft:
          buttonAlignment == Alignment.centerLeft
              ? roundedRadius
              : notRoundedRadius,
      bottomRight:
          buttonAlignment == Alignment.centerLeft
              ? notRoundedRadius
              : roundedRadius,
      topRight:
          buttonAlignment == Alignment.centerLeft
              ? notRoundedRadius
              : roundedRadius,
    );
  }

  return BorderRadius.only(
    bottomLeft:
        buttonAlignment != Alignment.centerLeft
            ? roundedRadius
            : notRoundedRadius,
    topLeft:
        buttonAlignment != Alignment.centerLeft
            ? roundedRadius
            : notRoundedRadius,
    bottomRight:
        buttonAlignment != Alignment.centerLeft
            ? notRoundedRadius
            : roundedRadius,
    topRight:
        buttonAlignment != Alignment.centerLeft
            ? notRoundedRadius
            : roundedRadius,
  );
}

Widget _buildQuantitySelectorButton({
  required TextDirection textDirection,
  required void Function() onTap,
  required Alignment buttonAlignment,
}) {
  return InkWell(
    borderRadius: _getBorderRadius(
      textDirection: textDirection,
      buttonAlignment: buttonAlignment,
    ),
    onTap: onTap,
    child: Ink(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: _getBorderRadius(
          textDirection: textDirection,
          buttonAlignment: buttonAlignment,
        ),
        color: AppColors.neutral_02,
      ),
      child: Center(
        child: Text(buttonAlignment == Alignment.centerRight ? '+' : '-'),
      ),
    ),
  );
}
