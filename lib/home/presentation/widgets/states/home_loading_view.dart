import '../../../../core/util/localization.dart';
import '../../../../core/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerBox(width: double.infinity, height: 300, borderRadius: 12),
              const SizedBox(height: 24),
              ShimmerBox(width: 300, height: 25, borderRadius: 360),
              const SizedBox(height: 8),
              ShimmerBox(width: 300, height: 25, borderRadius: 360),
              const SizedBox(height: 32),
              Builder(
                builder: (context) {
                  final screenWidth = MediaQuery.sizeOf(context).width;
                  const minimumCardWidth = 290.0;
                  const smallCardHeight = 180.0;
                  final doubleViewThreshold =
                      (minimumCardWidth * 2) +
                      64 + // Screen padding
                      16; // Spaces between cards
                  final tripleViewThreshold =
                      (minimumCardWidth * 3) +
                      64 + // Screen padding
                      32; // Spaces between cards

                  if (screenWidth >= tripleViewThreshold) {
                    return Row(
                      children: [
                        Expanded(child: _popularCategoryShimmer(false)),
                        const SizedBox(width: 16),
                        Expanded(child: _popularCategoryShimmer(false)),
                        const SizedBox(width: 16),
                        Expanded(child: _popularCategoryShimmer(false)),
                      ],
                    );
                  }

                  if (screenWidth >= doubleViewThreshold) {
                    return SizedBox(
                      height:
                          (smallCardHeight * 2) +
                          16, // 16 is vertical space between cards

                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(child: _popularCategoryShimmer(false)),
                                const SizedBox(width: 16),
                                Expanded(child: _popularCategoryShimmer(false)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          _popularCategoryShimmer(false),
                        ],
                      ),
                    );
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShimmerBox(
                        width: double.infinity,
                        height: 350,
                        borderRadius: 12,
                      ),
                      const SizedBox(height: 16),
                      ShimmerBox(
                        width: double.infinity,
                        height: 180,
                        borderRadius: 12,
                      ),
                      const SizedBox(height: 16),
                      ShimmerBox(
                        width: double.infinity,
                        height: 180,
                        borderRadius: 12,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        SingleChildScrollView(
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
        const SizedBox(height: 64),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 408,
                child: GridView.builder(
                  itemCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 3 / 4,
                    mainAxisExtent: 200,
                  ),
                  itemBuilder: (context, index) {
                    return ShimmerBox(
                      width: double.infinity,
                      height: double.infinity,
                      borderRadius: 12,
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              ShimmerBox(width: double.infinity, height: 350, borderRadius: 12),
              const SizedBox(height: 16),
              ShimmerBox(width: 200, height: 25, borderRadius: 360),
              const SizedBox(height: 8),
              ShimmerBox(width: 250, height: 15, borderRadius: 360),
              const SizedBox(height: 40),
              ...List.generate(
                3,
                (_) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(
                      width: double.infinity,
                      height: 300,
                      borderRadius: 12,
                    ),
                    const SizedBox(height: 12),
                    ShimmerBox(width: 200, height: 15, borderRadius: 360),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _popularCategoryShimmer(bool big) => ShimmerBox(
  width: double.infinity,
  height: big ? 350 : 180,
  borderRadius: 12,
);
