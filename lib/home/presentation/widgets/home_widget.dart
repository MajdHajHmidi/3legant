import '../../cubit/home_cubit.dart';
import '../../models/home_data_model.dart';
import 'home_app_features.dart';
import 'home_blog_tile.dart';
import 'home_blogs_title.dart';
import 'home_image_carrousel.dart';
import 'home_new_products.dart';
import 'home_popular_categories.dart';
import 'home_sales.dart';
import 'home_store_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidget extends StatelessWidget {
  final HomeDataModel homeDataModel;
  const HomeWidget({super.key, required this.homeDataModel});

  final horizontalPadding = const EdgeInsets.symmetric(horizontal: 32);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: horizontalPadding,
          sliver: SliverToBoxAdapter(
            child: HomeImageCarousel(
              images: [
                homeDataModel.metadata.thumbnailUrl1,
                homeDataModel.metadata.thumbnailUrl2,
                homeDataModel.metadata.thumbnailUrl3,
              ],
            ),
          ),
        ),
        SliverPadding(padding: const EdgeInsets.only(top: 32)),
        SliverPadding(
          padding: horizontalPadding,
          sliver: SliverToBoxAdapter(
            child: HomeStoreInfo(metadata: homeDataModel.metadata),
          ),
        ),
        SliverPadding(padding: const EdgeInsets.only(top: 40)),
        SliverPadding(
          padding: horizontalPadding,
          sliver: HomePopularCategories(
            categories: homeDataModel.popularCategories,
          ),
        ),
        SliverPadding(padding: const EdgeInsets.only(top: 32)),
        SliverToBoxAdapter(
          child: BlocProvider.value(
            value: context.read<HomeCubit>(),
            child: HomeNewProducts(
              products: homeDataModel.newProducts.products,
            ),
          ),
        ),
        SliverPadding(padding: const EdgeInsets.only(top: 64)),
        SliverPadding(
          padding: horizontalPadding,
          sliver: HomeAppFeatures(metadata: homeDataModel.metadata),
        ),
        SliverPadding(padding: const EdgeInsets.only(top: 32)),
        SliverToBoxAdapter(child: HomeSales(metadata: homeDataModel.metadata)),
        SliverPadding(padding: const EdgeInsets.only(top: 40)),
        SliverPadding(
          padding: horizontalPadding,
          sliver: SliverToBoxAdapter(child: HomeBlogsTitle()),
        ),
        SliverPadding(padding: const EdgeInsets.only(top: 40)),
        SliverPadding(
          padding: horizontalPadding,
          sliver: SliverList.separated(
            itemCount: homeDataModel.popularBlogs.blogs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemBuilder:
                (context, index) =>
                    HomeBlogTile(blog: homeDataModel.popularBlogs.blogs[index]),
          ),
        ),
        SliverPadding(padding: const EdgeInsets.only(top: 40)),
      ],
    );
  }
}
