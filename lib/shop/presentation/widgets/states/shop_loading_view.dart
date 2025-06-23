import '../../../../core/util/localization.dart';
import '../../../../core/widgets/shimmer.dart';
import '../../../../core/widgets/sliver_util.dart';
import '../products_loading_widget.dart';
import 'package:flutter/material.dart';

class ShopLoadingView extends StatelessWidget {
  const ShopLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          sliver: SliverMainAxisGroup(
            slivers: [
              const SliverShimmerBox(
                width: double.infinity,
                height: 300,
                borderRadius: 12,
              ),
              const SliverIndent(height: 32),
              SliverLayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.crossAxisExtent;

                  return SliverShimmerBox(
                    width: maxWidth * 0.7,
                    height: 30,
                    alignment: getValueWithDirection(
                      context,
                      Alignment.centerLeft,
                      Alignment.centerRight,
                    ),
                    borderRadius: 16,
                  );
                },
              ),
              const SliverIndent(height: 8),
              const SliverShimmerBox(
                width: double.infinity,
                height: 60,
                borderRadius: 12,
              ),
              const SliverIndent(height: 32),
              const ProductsLoadingWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
