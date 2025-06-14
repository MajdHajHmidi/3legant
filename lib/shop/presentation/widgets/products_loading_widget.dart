import '../../../core/widgets/app_adaptive_grid.dart';
import '../../../core/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class ProductsLoadingWidget extends StatelessWidget {
  const ProductsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAdaptiveSliverGrid(
      itemCount: 10,
      minimumTileWidth: 230,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      staticChildHeight: 410,
      itembuilder:
          (context, index) => ShimmerBox(
            width: double.infinity,
            height: double.infinity,
            borderRadius: 12,
          ),
    );
  }
}
