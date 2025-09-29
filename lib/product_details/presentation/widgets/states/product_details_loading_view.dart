import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/shimmer.dart';
import 'package:e_commerce/core/widgets/sliver_util.dart';
import 'package:flutter/material.dart';

class ProductDetailsLoadingView extends StatelessWidget {
  const ProductDetailsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverIndent(height: 16),
              SliverShimmerBox(
                width: double.infinity,
                height: 300,
                borderRadius: 12,
              ),
              SliverIndent(height: 32),
              SliverShimmerBox(
                width: double.infinity,
                height: 50,
                borderRadius: 360,
              ),
              SliverIndent(height: 16),
              SliverList.separated(
                itemCount: 4,
                itemBuilder:
                    (context, index) => ShimmerBox(
                      width: double.infinity,
                      height: 30,
                      borderRadius: 360,
                    ),
                separatorBuilder: (_, _) => SizedBox(height: 8),
              ),
              SliverIndent(height: 32),
              SliverList.separated(
                itemCount: 2,
                itemBuilder:
                    (context, index) => ShimmerBox(
                      width: double.infinity,
                      height: 80,
                      borderRadius: 12,
                    ),
                separatorBuilder: (_, _) => SizedBox(height: 32),
              ),
              SliverIndent(height: 32),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(10, (index) {
                  EdgeInsets getItemPadding() {
                    if (index == 0) {
                      return EdgeInsets.only(
                        right: getValueWithDirection(context, 8.0, 32.0),
                        left: getValueWithDirection(context, 32.0, 8.0),
                      );
                    } else if (index == 9) {
                      return EdgeInsets.only(
                        right: getValueWithDirection(context, 32.0, 8.0),
                        left: getValueWithDirection(context, 8.0, 32.0),
                      );
                    }

                    return const EdgeInsets.only(right: 8, left: 8);
                  }

                  return Container(
                    width: 270,
                    padding: getItemPadding(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerBox(
                          width: double.infinity,
                          height: 250,
                          borderRadius: 12,
                        ),
                        const SizedBox(height: 12),
                        ShimmerBox(
                          width: double.infinity,
                          height: 40,
                          borderRadius: 8,
                        ),
                        const SizedBox(height: 12),
                        ShimmerBox(width: 150, height: 10, borderRadius: 8),
                        const SizedBox(height: 4),
                        ShimmerBox(width: 75, height: 10, borderRadius: 8),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverIndent(height: 32),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ShimmerBox(width: 0, height: 40, borderRadius: 8),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 5,
                      child: ShimmerBox(width: 0, height: 40, borderRadius: 8),
                    ),
                  ],
                ),
              ),
              SliverIndent(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}
