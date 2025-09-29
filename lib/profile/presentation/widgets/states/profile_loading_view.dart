import 'package:e_commerce/core/widgets/shimmer.dart';
import 'package:e_commerce/core/widgets/sliver_util.dart';
import 'package:flutter/material.dart';
import 'package:sliver_center/sliver_center.dart';

class ProfileLoadingView extends StatelessWidget {
  const ProfileLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverConstrainedCrossAxis(
          maxExtent: 700,
          sliver: SliverCenter(
            sliver: SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              sliver: SliverMainAxisGroup(
                slivers: [
                  SliverIndent(height: 48),
                  SliverShimmerBox(
                    width: double.infinity,
                    height: 300,
                    borderRadius: 12,
                  ),
                  SliverIndent(height: 40),
                  SliverList.separated(
                    itemCount: 2,
                    itemBuilder:
                        (context, index) => ShimmerBox(
                          width: double.infinity,
                          height: 80,
                          borderRadius: 12,
                        ),
                    separatorBuilder: (_, _) => SizedBox(height: 16),
                  ),
                  SliverIndent(height: 32),
                  SliverShimmerBox(
                    width: double.infinity,
                    height: 60,
                    borderRadius: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
