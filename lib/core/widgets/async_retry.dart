import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AsyncRetryWidget extends StatelessWidget {
  final String message;
  final void Function() onPressed;
  const AsyncRetryWidget({
    super.key,
    required this.message,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.refresh, color: AppColors.neutral_05, size: 26,),
        ),
        Text(
          message,
          style: AppTextStyles.buttonS.copyWith(color: AppColors.neutral_05),
        ),
      ],
    );
  }
}
