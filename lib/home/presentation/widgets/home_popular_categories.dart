import '../../models/home_data_model.dart';
import 'home_category_tile.dart';
import 'package:flutter/material.dart';

class HomePopularCategories extends StatelessWidget {
  final List<PopularCategory> categories;
  const HomePopularCategories({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Builder(
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
          // SliverList doesn't provide a `ScrollDirection` property
          return SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: HomeCategoryTile.small(
                    categoryId: categories[0].id,
                    categoryName: categories[0].name,
                    imageUrl: categories[0].imageUrl,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: HomeCategoryTile.small(
                    categoryId: categories[1].id,
                    categoryName: categories[1].name,
                    imageUrl: categories[1].imageUrl,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: HomeCategoryTile.small(
                    categoryId: categories[2].id,
                    categoryName: categories[2].name,
                    imageUrl: categories[2].imageUrl,
                  ),
                ),
              ],
            ),
          );
        } else if (screenWidth >= doubleViewThreshold) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height:
                  (smallCardHeight * 2) +
                  16, // 16 is vertical space between cards

              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: HomeCategoryTile.small(
                            categoryId: categories[0].id,
                            categoryName: categories[0].name,
                            imageUrl: categories[0].imageUrl,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: HomeCategoryTile.small(
                            categoryId: categories[1].id,
                            categoryName: categories[1].name,
                            imageUrl: categories[1].imageUrl,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  HomeCategoryTile.small(
                    categoryId: categories[2].id,
                    categoryName: categories[2].name,
                    imageUrl: categories[2].imageUrl,
                  ),
                ],
              ),
            ),
          );
        }

        return SliverList.separated(
          itemCount: categories.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final category = categories[index];

            if (index == 0) {
              return HomeCategoryTile.big(
                categoryId: category.id,
                categoryName: category.name,
                imageUrl: category.imageUrl,
              );
            }

            return HomeCategoryTile.small(
              categoryId: category.id,
              categoryName: category.name,
              imageUrl: category.imageUrl,
            );
          },
        );
      },
    );
  }
}
