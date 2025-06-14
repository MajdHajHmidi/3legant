import 'package:dropdown_button2/dropdown_button2.dart';
import '../constants/app_assets.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import 'package:flex_dropdown/flex_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

class AppDropdownButton<T> extends StatelessWidget {
  final T value;
  final T defaultValue;
  final double? width;
  final String defaultText;
  final Map<T, String> items;
  final void Function(T?) onChanged;
  const AppDropdownButton({
    super.key,
    required this.value,
    required this.items,
    this.width,
    required this.defaultValue,
    required this.defaultText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final dropdownIcon = SvgPicture.asset(
      AppIcons.dropdown,
      theme: SvgTheme(currentColor: AppColors.neutral_04),
    );
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        value: value,
        isExpanded: true,
        style: AppTextStyles.body2Semi.copyWith(color: AppColors.neutral_06),
        buttonStyleData: ButtonStyleData(
          width: width,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.neutral_04, width: 2),
          ),
          height: 48 * MediaQuery.textScalerOf(context).scale(1),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        iconStyleData: IconStyleData(
          icon: dropdownIcon,
          openMenuIcon: Transform.rotate(angle: math.pi, child: dropdownIcon),
          iconSize: 24 * MediaQuery.textScalerOf(context).scale(1),
        ),
        items: [
          DropdownMenuItem(value: defaultValue, child: Text(defaultText)),
          ...items.entries.map(
            (entry) =>
                DropdownMenuItem(value: entry.key, child: Text(entry.value)),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}

class CustomAppDropdownButton extends StatelessWidget {
  final String text;
  final Widget Function(
    BuildContext context,
    double? width,
    OverlayPortalController controller,
  )
  menuBuilder;
  const CustomAppDropdownButton({
    super.key,
    required this.text,
    required this.menuBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final OverlayPortalController controller = OverlayPortalController();

    return RawFlexDropDown(
      controller: controller,
      dismissOnTapOutside: true,
      buttonBuilder: (context, onTap) {
        return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.neutral_04, width: 2),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: AppTextStyles.body2Semi.copyWith(
                      color: AppColors.neutral_06,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  AppIcons.dropdown,
                  width: 24 * MediaQuery.textScalerOf(context).scale(1),
                  theme: SvgTheme(currentColor: AppColors.neutral_04),
                ),
              ],
            ),
          ),
        );
      },
      menuBuilder: (context, width) => menuBuilder(context, width, controller),
    );
  }
}
