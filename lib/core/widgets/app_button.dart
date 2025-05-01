import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool lightTheme;
  final Widget? prefixIcon;
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.lightTheme = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      style: AppTextStyles.buttonS.copyWith(
        color: lightTheme ? AppColors.neutral_06 : AppColors.neutral_01,
      ),
    );

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor:
              lightTheme
                  ? AppColors.neutral_02
                  : AppColors.neutral_07,
          elevation: 0,
        ),
        child:
            prefixIcon != null
                ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [prefixIcon!, SizedBox(width: 16), textWidget],
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
      // child: InkWell(
      //   borderRadius: BorderRadius.circular(8),
      //   onTap: onPressed,
      //   child: Ink(
      //     decoration: BoxDecoration(
      //       color:
      //           lightTheme
      //               ? AppColors.neutral_03.withAlpha(127)
      //               : AppColors.neutral_07,
      //       borderRadius: BorderRadius.circular(8),
      //     ),
      //     child:
      //         prefixIcon != null
      //             ? Padding(
      //               padding: const EdgeInsets.symmetric(vertical: 10),
      //               child: Center(
      //                 child: Row(
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: [
      //                     prefixIcon!,
      //                     SizedBox(width: 16),
      //                     textWidget,
      //                   ],
      //                 ),
      //               ),
      //             )
      //             : Center(
      //               child: Padding(
      //                 padding: const EdgeInsets.symmetric(vertical: 12),
      //                 child: textWidget,
      //               ),
      //             ),
      //   ),
      // ),
    );
  }
}
