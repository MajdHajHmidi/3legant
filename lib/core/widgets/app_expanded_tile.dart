import 'package:e_commerce/core/constants/app_assets.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/duration_extension.dart';
import 'package:e_commerce/core/widgets/app_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppExpandedContent extends StatelessWidget {
  final Widget child;
  final bool isExpanded;
  final Duration duration;
  final Curve curve;
  AppExpandedContent({
    super.key,
    required this.child,
    required this.isExpanded,
    this.curve = Curves.easeInOut,
    Duration? duration,
  }) : duration = duration ?? 350.ms;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: duration,
      curve: curve,
      alignment: Alignment.topCenter,
      child: isExpanded ? child : const SizedBox.shrink(),
    );
  }
}

class AppExpandedTile extends StatelessWidget {
  final String text;
  final bool isExpanded;
  final void Function() onTap;
  const AppExpandedTile({
    super.key,
    required this.isExpanded,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: AppTextStyles.buttonM.copyWith(
                      color: AppColors.neutral_07,
                      fontWeight: isExpanded ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0.0,
                  duration: 250.ms,
                  curve: Curves.easeOut,
                  child: _getDropdownIcon(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            AppDivider(color: AppColors.neutral_07),
          ],
        ),
      ),
    );
  }
}

Widget _getDropdownIcon() {
  return SvgPicture.asset(
    AppIcons.dropdown,
    width: 24,
    height: 24,
    // ignore: deprecated_member_use
    color: AppColors.neutral_04,
  );
}
