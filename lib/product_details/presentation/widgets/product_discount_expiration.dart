import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/duration_extension.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/product_details/models/product_details_model.dart';
import 'package:flutter/material.dart';

class ProductDiscountExpiration extends StatelessWidget {
  final ProductDetailsModel model;
  final Stream<Duration> durationStream;
  const ProductDiscountExpiration({
    super.key,
    required this.model,
    required this.durationStream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: durationStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return SizedBox.shrink();

        final remaining = snapshot.data!;
        if (remaining == Duration.zero) {
          return Center(
            child: Text(
              '${localization(context).offerExpiresIn}:',
              style: AppTextStyles.body2.copyWith(color: AppColors.neutral_05),
            ),
          );
        }

        final days = remaining.inDays;
        final hours = remaining.inHours % 24;
        final minutes = remaining.inMinutes % 60;
        final seconds = remaining.inSeconds % 60;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${localization(context).offerExpiresIn}:',
              style: AppTextStyles.body2.copyWith(color: AppColors.neutral_05),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 16,
              children: [
                _buildCountdownUnitBox(
                  context: context,
                  value: days,
                  hint: localization(context).days,
                ),
                _buildCountdownUnitBox(
                  context: context,
                  value: hours,
                  hint: localization(context).hours,
                ),
                _buildCountdownUnitBox(
                  context: context,
                  value: minutes,
                  hint: localization(context).minutes,
                ),
                _buildCountdownUnitBox(
                  context: context,
                  value: seconds,
                  hint: localization(context).seconds,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

Widget _buildCountdownUnitBox({
  required BuildContext context,
  required int value,
  required String hint,
}) {
  final boxSize = 60 * MediaQuery.textScalerOf(context).scale(1);

  return Column(
    children: [
      Container(
        width: boxSize,
        height: boxSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.neutral_02,
          borderRadius: BorderRadius.circular(6),
        ),
        child: ClipRRect(
          child: AnimatedSwitcher(
            duration: 600.ms,
            switchInCurve: Curves.easeOutExpo,
            switchOutCurve: Curves.easeInExpo,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return Stack(
                children: <Widget>[
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -1),
                      end: const Offset(0, 1),
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                    child: FadeTransition(opacity: animation, child: child),
                  ),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -1),
                      end: const Offset(0, 0),
                    ).animate(
                      CurvedAnimation(parent: animation, curve: Curves.bounceIn),
                    ),
                    child: FadeTransition(opacity: animation, child: child),
                  ),
                ],
              );
            },
            child: Text(
              key: ValueKey(value),
              value.toString(),
              style: AppTextStyles.headline5.copyWith(
                color: AppColors.neutral_07,
              ),
            ),
          ),
        ),
      ),
      Text(
        hint,
        style: AppTextStyles.caption2.copyWith(color: AppColors.neutral_04),
      ),
    ],
  );
}
