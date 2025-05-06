import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/duration_extension.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool lightTheme;
  final Widget? prefixIcon;
  final bool loading;
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.lightTheme = false,
    this.prefixIcon,
    this.loading = false,
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
      child: Text(text, overflow: TextOverflow.ellipsis, maxLines: 1),
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loading ? () {} : onPressed,
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(0),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return lightTheme ? AppColors.neutral_07.withAlpha(30) : AppColors.neutral_02.withAlpha(30);
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
                  child: CircularProgressIndicator(
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
