import '../../../../auth/data/auth_repo.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/util/dependency_injection.dart';
import '../../../../core/util/localization.dart';
import '../../../../core/widgets/app_adaptive_grid.dart';

import '../../cubit/home_cubit.dart';
import '../../../models/home_data_model.dart';
import '../home_app_features.dart';
import '../home_blog_tile.dart';
import '../home_blogs_title.dart';
import '../home_image_carrousel.dart';
import '../home_new_products.dart';
import '../home_popular_categories.dart';
import '../home_sales.dart';
import '../home_store_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDataView extends StatelessWidget {
  final HomeDataModel homeDataModel;
  const HomeDataView({super.key, required this.homeDataModel});

  final horizontalPadding = const EdgeInsets.symmetric(horizontal: 32);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final user = serviceLocator<AuthRepo>().getCurrentUser()?.id;

        if (user != null) {
          context.read<HomeCubit>().getHomeData(user);
        }
      },
      child: CustomScrollView(
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
          SliverToBoxAdapter(
            child: HomeSales(metadata: homeDataModel.metadata),
          ),
          SliverPadding(padding: const EdgeInsets.only(top: 40)),
          SliverPadding(
            padding: horizontalPadding,
            sliver: SliverToBoxAdapter(child: HomeBlogsTitle()),
          ),
          SliverPadding(padding: const EdgeInsets.only(top: 40)),
          SliverPadding(
            padding: horizontalPadding,
            sliver: AppAdaptiveSliverGrid(
              itembuilder:
                  (context, index) => HomeBlogTile(
                    blog: homeDataModel.popularBlogs.blogs[index],
                  ),
              itemCount: homeDataModel.popularBlogs.blogs.length,
              minimumTileWidth: 300.0,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              staticChildHeight: 320,
              textPlaceholders: [
                TextPlaceholderParams(
                  context: context,
                  texts:
                      homeDataModel.popularBlogs.blogs
                          .map((blog) => blog.title)
                          .toList(),
                  horizontalPadding: 8,
                  style: AppTextStyles.body2Semi,
                  maxLines: 2,
                ),
                TextPlaceholderParams(
                  context: context,
                  text: localization(context).readMore,
                  style: AppTextStyles.buttonXS,
                  maxWidth: 100,
                  maxLines: 1,
                  noScaling: true,
                  horizontalPadding: 8,
                ),
              ],
            ),
          ),
          SliverPadding(padding: const EdgeInsets.only(top: 40)),
        ],
      ),
    );
  }
}
