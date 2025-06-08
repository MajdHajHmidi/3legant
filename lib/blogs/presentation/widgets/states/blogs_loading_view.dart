import 'package:e_commerce/core/widgets/app_adaptive_grid.dart';
import 'package:e_commerce/core/widgets/shimmer.dart';
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
              AppAdaptiveSliverGrid(
                builder:
                    (_, _) => ShimmerBox(
                      width: double.infinity,
                      height: double.infinity,
                      borderRadius: 12,
                    ),
                itemCount: 5,
                minimumTileWidth: 300.0,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                staticChildHeight: 320,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
