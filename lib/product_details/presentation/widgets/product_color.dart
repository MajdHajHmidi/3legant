import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/collections.dart';
import 'package:e_commerce/core/util/duration_extension.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/product_details/models/product_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;

class ProductColor extends StatelessWidget {
  final ProductDetailsModel model;
  final int selectedColorIndex;
  final void Function(int index) changeSelectedColorHandler;
  const ProductColor({
    super.key,
    required this.model,
    required this.selectedColorIndex,
    required this.changeSelectedColorHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          key: ValueKey(selectedColorIndex),
          TextSpan(
            children: [
              TextSpan(
                text: '${localization(context).chooseColor} ',
                style: AppTextStyles.body2Semi.copyWith(
                  color: AppColors.neutral_04,
                ),
              ),
              TextSpan(
                text: '(${model.colors[selectedColorIndex].name})',
                style: AppTextStyles.body2Semi.copyWith(
                  color: AppColors.neutral_07,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 52,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            children:
                model.colors
                    .mapIndexed(
                      (productColor, index) => _buildColorOption(
                        color: HexColor(productColor.hex),
                        isSelected: selectedColorIndex == index,
                        onTap: () => changeSelectedColorHandler(index),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}

Widget _buildColorOption({
  required material.Color color,
  required bool isSelected,
  required void Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      height: 52,
      width: 52,
      child: Align(
        child: AnimatedContainer(
          duration: 250.ms,
          curve: Curves.easeInCubic,
          width: isSelected ? 52 : 24,
          height: isSelected ? 52 : 24,
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(isSelected ? 12 : 360),
            border: Border.all(color: AppColors.neutral_03, width: 1.5),
          ),
        ),
      ),
    ),
  );
}
