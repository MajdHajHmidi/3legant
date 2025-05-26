import '../constants/app_assets.dart';
import '../util/localization.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../util/duration_extension.dart';
import 'app_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool lightTheme;
  final Widget? prefixIcon;
  final bool loading;
  final double width;
  final double height;
  final bool disableTextScaling;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.lightTheme = false,
    this.prefixIcon,
    this.loading = false,
    this.width = double.infinity,
    this.height = 52,
    this.disableTextScaling = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = loading || onPressed == null;

    final textWidget = AnimatedDefaultTextStyle(
      duration: 200.ms,
      style: AppTextStyles.buttonS.copyWith(
        color:
            // If button is disabled, white color, otherwise, light theme: black, dark theme: white
            isDisabled
                ? HexColor('#F5F5F5')
                : lightTheme
                ? AppColors.neutral_06
                : AppColors.neutral_01,
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textScaler: disableTextScaling ? TextScaler.linear(1) : null,
      ),
    );

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: loading ? () {} : onPressed,
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(0),
          minimumSize: WidgetStatePropertyAll(Size(0, height)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return lightTheme
                  ? AppColors.neutral_07.withAlpha(30)
                  : AppColors.neutral_02.withAlpha(30);
            }

            return null;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return HexColor('#E1E2E2');
            }
            return lightTheme ? AppColors.neutral_02 : AppColors.neutral_07;
          }),
        ),
        child:
            loading
                ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: AppCircularProgressIndicator(
                    color:
                        lightTheme
                            ? AppColors.neutral_06
                            : AppColors.neutral_01,
                  ),
                )
                : prefixIcon != null
                ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Opacity(
                            opacity: isDisabled ? 0.5 : 1,
                            child: prefixIcon!,
                          ),
                        ),
                        SizedBox(width: 16),
                        Flexible(flex: 3, child: textWidget),
                      ],
                    ),
                  ),
                )
                : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: textWidget,
                  ),
                ),
      ),
    );
  }
}

class SecondayAppButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool lightTheme;
  final Widget? prefixIcon;
  final bool loading;
  final double width;
  final double height;
  final bool disableTextScaling;

  const SecondayAppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.lightTheme = false,
    this.prefixIcon,
    this.loading = false,
    this.width = double.infinity,
    this.height = 52,
    this.disableTextScaling = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          color: lightTheme ? AppColors.neutral_02 : AppColors.neutral_07,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        height: height,
        child: Center(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppTextStyles.buttonS.copyWith(
              color: lightTheme ? AppColors.neutral_06 : AppColors.neutral_01,
            ),
            textScaler: disableTextScaling ? TextScaler.linear(1) : null,
          ),
        ),
      ),
    );
  }
}

class AppTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const AppTextButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: AppColors.neutral_07),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              textScaler: TextScaler.linear(1),
              style: AppTextStyles.buttonXS.copyWith(
                color: AppColors.neutral_07,
              ),
            ),
            const SizedBox(width: 4),
            SvgPicture.asset(
              getValueWithDirection(
                context,
                AppIcons.arrowRight,
                AppIcons.arrowLeft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
