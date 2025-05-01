import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final Widget? suffixIcon;
  final TextInputAction textInputAction;
  final void Function()? onSuffixIconPressed;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged;
  final void Function(String value)? onFieldSubmitted;
  const AppTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    this.validator,
    this.obscure = false,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.onFieldSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      style: AppTextStyles.caption1,
      obscureText: obscure,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.caption1.copyWith(
          color: AppColors.neutral_04.withAlpha(191),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.neutral_03),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: AppColors.neutral_06),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.red),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: AppColors.red),
        ),
        suffixIcon:
            suffixIcon == null
                ? null
                : GestureDetector(
                  onTap: onSuffixIconPressed,
                  child: suffixIcon,
                ),
      ),
    );
  }
}
