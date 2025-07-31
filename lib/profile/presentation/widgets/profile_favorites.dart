import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/profile/domain/profile_data_model.dart';
import 'package:e_commerce/profile/presentation/widgets/favorite_product_tile.dart';
import 'package:flutter/material.dart';

class ProfileFavorites extends StatelessWidget {
  final List<Product> products;
  const ProfileFavorites({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: products.length,
      separatorBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Divider(color: AppColors.neutral_03, thickness: 1, height: 0),
        );
      },
      itemBuilder:
          (context, index) => FavoriteProductTile(product: products[index]),
    );
  }
}
