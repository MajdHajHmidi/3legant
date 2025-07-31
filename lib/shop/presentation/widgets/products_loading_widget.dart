import 'package:adaptive_grid/adaptive_grid.dart';
import '../../../core/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class ProductsLoadingWidget extends StatelessWidget {
  const ProductsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveGrid.sliver(
      itemCount: 10,
      minimumItemWidth: 230,
      verticalSpacing: 16,
      horizontalSpacing: 16,
      itemBuilder:
          (context, index) =>
              ShimmerBox(width: double.infinity, height: 410, borderRadius: 12),
    );
  }
}
