import 'package:e_commerce/core/styles/colors.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  final bool value;
  final void Function(bool? value) onChanged;
  const AppCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        side: BorderSide(color: AppColors.neutral_04, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        // -4 is the minimum density for both vertical and horizontal axis
        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      ),
    );
  }
}
