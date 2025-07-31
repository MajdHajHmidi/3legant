import 'package:adaptive_grid/adaptive_grid.dart';

import '../../../../core/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class BlogsLoadingView extends StatelessWidget {
  const BlogsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: ShimmerBox(
                  width: double.infinity,
                  height: 300,
                  borderRadius: 12,
                ),
              ),
              SliverPadding(padding: const EdgeInsets.only(top: 16)),
              SliverToBoxAdapter(
                child: ShimmerBox(
                  width: double.infinity,
                  height: 50,
                  borderRadius: 8,
                ),
              ),
              SliverPadding(padding: const EdgeInsets.only(top: 16)),
              AdaptiveGrid.sliver(
                itemBuilder:
                    (_, _) => ShimmerBox(
                      width: double.infinity,
                      height: 320,
                      borderRadius: 12,
                    ),
                itemCount: 5,
                minimumItemWidth: 300.0,
                verticalSpacing: 16,
                horizontalSpacing: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
