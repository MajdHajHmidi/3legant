import 'package:e_commerce/core/styles/colors.dart';
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final Color color;
  final double height;
  final double thickness;
  const AppDivider({
    super.key,
    Color? color,
    this.height = 1,
    this.thickness = 1,
  }) : color = AppColors.neutral_03;

  @override
  Widget build(BuildContext context) {
    return Divider(color: color, height: height, thickness: thickness);
  }
}
