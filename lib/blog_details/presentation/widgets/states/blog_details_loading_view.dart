import 'package:adaptive_grid/adaptive_grid.dart';

import '../../../../core/util/localization.dart';
// ignore: depend_on_referenced_packages
import 'package:sliver_center/sliver_center.dart';
import 'package:e_commerce/core/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class BlogDetailsLoadingView extends StatelessWidget {
  const BlogDetailsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverConstrainedCrossAxis(
          maxExtent: 850,
          sliver: SliverCenter(
            sliver: SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              sliver: SliverLayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.crossAxisExtent;

                  return SliverMainAxisGroup(
                    slivers: [
                      SliverList.list(
                        children: [
                          Align(
                            alignment: getValueWithDirection(
                              context,
                              Alignment.centerLeft,
                              Alignment.centerRight,
                            ),
                            child: ShimmerBox(
                              width: width / 1.1,
                              height: 25,
                              borderRadius: 360,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: getValueWithDirection(
                              context,
                              Alignment.centerLeft,
                              Alignment.centerRight,
                            ),
                            child: ShimmerBox(
                              width: width / 1.5,
                              height: 25,
                              borderRadius: 360,
                            ),
                          ),
                        ],
                      ),
                      SliverPadding(padding: const EdgeInsets.only(top: 16)),
                      SliverList.separated(
                        itemCount: 2,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder:
                            (_, _) => Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ShimmerBox(
                                  width: width,
                                  height: 300,
                                  borderRadius: 12,
                                ),
                                const SizedBox(height: 8),
                                ShimmerBox(
                                  width: width,
                                  height: 25,
                                  borderRadius: 12,
                                ),
                                const SizedBox(height: 8),
                                ShimmerBox(
                                  width: width,
                                  height: 25,
                                  borderRadius: 12,
                                ),
                                const SizedBox(height: 8),
                                ShimmerBox(
                                  width: width,
                                  height: 25,
                                  borderRadius: 12,
                                ),
                              ],
                            ),
                      ),
                      SliverPadding(padding: const EdgeInsets.only(top: 24)),
                      SliverToBoxAdapter(
                        child: Align(
                          alignment: getValueWithDirection(
                            context,
                            Alignment.centerLeft,
                            Alignment.centerRight,
                          ),
                          child: ShimmerBox(
                            width: 150,
                            height: 25,
                            borderRadius: 360,
                          ),
                        ),
                      ),
                      SliverPadding(padding: const EdgeInsets.only(top: 12)),
                      AdaptiveGrid.sliver(
                        itemBuilder:
                            (_, _) => ShimmerBox(
                              width: double.infinity,
                              height: 320,
                              borderRadius: 12,
                            ),
                        itemCount: 2,
                        minimumItemWidth: 300.0,
                        verticalSpacing: 16,
                        horizontalSpacing: 16,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
