import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:flutter/material.dart';

class CartViewModeIndicatorTile extends StatelessWidget {
  final String text;
  final int index;
  final bool isSelected;
  const CartViewModeIndicatorTile({
    super.key,
    required this.text,
    required this.index,
    required this.isSelected,
  });

  // This makes it clean to calculate the size of the current widget when
  // used in other widget trees
  static double widgetHeight(BuildContext context) {
    return 24 * 2
        // Vertical widget padding
        +
        40 * MediaQuery.textScalerOf(context).scale(1)
    // Height of text inside black indicator
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isSelected ? getValueWithDirection(context, 60.0, 0.0) : 0,
        right: isSelected ? getValueWithDirection(context, 0.0, 60.0) : 0,
      ),
      child: Row(
        children: [
          Container(
            width: 40 * MediaQuery.textScalerOf(context).scale(1),
            height: 40 * MediaQuery.textScalerOf(context).scale(1),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? AppColors.neutral_07
                      : AppColors.neutral_04.withAlpha(100),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: AppTextStyles.body2Semi.copyWith(
                  color: AppColors.neutral_01,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body2Semi.copyWith(
                color: AppColors.neutral_07,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
