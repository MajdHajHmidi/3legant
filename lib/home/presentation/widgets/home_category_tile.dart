import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/util/localization.dart';
import '../../../core/util/testing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_image.dart';
import 'package:flutter/material.dart';

class HomeCategoryTile extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final String imageUrl;
  final bool _big;

  const HomeCategoryTile.small({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.imageUrl,
  }) : _big = false;

  const HomeCategoryTile.big({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.imageUrl,
  }) : _big = true;

  @override
  Widget build(BuildContext context) {
    if (_big) {
      return GestureDetector(
        onTap: () => showNotImplementedDialog(context),
        child: Container(
          height: 350,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: HexColor('#F3F5F7'),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 32,
                    left: getValueWithDirection(context, 32.0, 0.0),
                    right: getValueWithDirection(context, 0.0, 32.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categoryName,
                        textScaler: TextScaler.linear(1),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: AppTextStyles.headline6.copyWith(
                          color: AppColors.neutral_07,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AppTextButton(text: localization(context).homeShopNow),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.center,
                  child: AppNetworkImage.noShimmer(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => showNotImplementedDialog(context),
      child: Container(
        height: 180,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: HexColor('#F3F5F7'),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 0,
                  left: getValueWithDirection(context, 32.0, 0.0),
                  right: getValueWithDirection(context, 0.0, 32.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryName,
                      textScaler: TextScaler.linear(1),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: AppTextStyles.headline6.copyWith(
                        color: AppColors.neutral_07,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AppTextButton(text: localization(context).homeShopNow),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.centerRight,
                child: AppNetworkImage.noShimmer(
                  imageUrl: imageUrl,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
