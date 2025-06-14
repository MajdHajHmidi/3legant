import '../../../core/constants/app_assets.dart';
import '../../../core/styles/colors.dart';
import '../../../core/util/duration_extension.dart';
import '../cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductsLayoutSwitch extends StatelessWidget {
  final ProductsViewLayout layout;
  final double height;
  final void Function(ProductsViewLayout productsViewLayout)
  layoutToggleCallback;
  const ProductsLayoutSwitch({
    super.key,
    required this.layout,
    required this.layoutToggleCallback,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.neutral_03, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildLayoutSwitchButton(
              selected: layout == ProductsViewLayout.grid,
              layout: ProductsViewLayout.grid,
              layoutToggleCallback: layoutToggleCallback,
            ),
          ),
          Expanded(
            child: _buildLayoutSwitchButton(
              selected: layout == ProductsViewLayout.list,
              layout: ProductsViewLayout.list,
              layoutToggleCallback: layoutToggleCallback,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildLayoutSwitchButton({
  required bool selected,
  required ProductsViewLayout layout,
  required void Function(ProductsViewLayout productsViewLayout)
  layoutToggleCallback,
}) {
  final isGrid = layout == ProductsViewLayout.grid;
  final roundedRadius = Radius.circular(8);
  final noRadius = Radius.circular(0);

  return InkWell(
    borderRadius: BorderRadius.only(
      topLeft: isGrid ? roundedRadius : noRadius,
      bottomLeft: isGrid ? roundedRadius : noRadius,
      topRight: isGrid ? noRadius : roundedRadius,
      bottomRight: isGrid ? noRadius : roundedRadius,
    ),
    onTap: () => layoutToggleCallback(layout),
    child: AnimatedContainer(
      duration: 300.ms,
      curve: Curves.fastOutSlowIn,
      height: double.infinity,
      decoration: BoxDecoration(
        color: selected ? AppColors.neutral_03 : null,
        border: Border.all(color: AppColors.neutral_03, width: 0.5),
      ),
      child: Align(
        child: SvgPicture.asset(
          width: 24,
          isGrid ? AppIcons.grid : AppIcons.list,
          // ignore: deprecated_member_use
          color: selected ? AppColors.neutral_07 : AppColors.neutral_04,
          theme: SvgTheme(
            currentColor:
                selected ? AppColors.neutral_07 : AppColors.neutral_04,
          ),
        ),
      ),
    ),
  );
}
