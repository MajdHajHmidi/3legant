import 'package:e_commerce/blogs/presentation/cubit/blogs_cubit.dart';
import 'package:e_commerce/blogs/presentation/widgets/blog_tile.dart';
import 'package:e_commerce/blogs/presentation/widgets/blogs_category_dropdown.dart';
import 'package:e_commerce/blogs/presentation/widgets/blogs_header.dart';
import 'package:e_commerce/blogs/presentation/widgets/blogs_show_more.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/widgets/app_adaptive_grid.dart';
import 'package:e_commerce/core/widgets/app_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsDataView extends StatelessWidget {
  final BlogsCubit cubit;
  const BlogsDataView({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final model = cubit.blogsDataModel.data!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: BlogsHeader(metadata: model.blogsMetadata)),
          SliverPadding(padding: const EdgeInsets.only(top: 32)),
          SliverToBoxAdapter(child: BlogsCategoryDropdown(cubit: cubit)),
          SliverPadding(padding: const EdgeInsets.only(top: 32)),
          BlocBuilder<BlogsCubit, BlogsState>(
            bloc: cubit,
            buildWhen:
                (_, state) =>
                    state is BlogsChangedCategoryLoadingState ||
                    state is BlogsChangedCategoryErrorState ||
                    state is BlogsDataChangedState,
            builder: (context, state) {
              if (state is BlogsChangedCategoryLoadingState) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 300,
                    child: Center(child: AppCircularProgressIndicator()),
                  ),
                );
              }

              return SliverMainAxisGroup(
                slivers: [
                  AppAdaptiveSliverGrid(
                    builder:
                        (context, index) => BlogTile(blog: model.blogs[index]),
                    itemCount: model.blogs.length,
                    minimumTileWidth: 300.0,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    staticChildHeight: 320,
                    textPlaceholders: [
                      TextPlaceholderParams(
                        context: context,
                        texts: model.blogs.map((blog) => blog.title).toList(),
                        horizontalPadding: 8,
                        style: AppTextStyles.body2Semi,
                        maxLines: 2,
                      ),
                      TextPlaceholderParams(
                        context: context,
                        text:
                            'September 30, 2025', // Sample that applies to all other cases
                        style: AppTextStyles.caption2,
                        maxLines: 1,
                        horizontalPadding: 8,
                      ),
                    ],
                  ),
                  if (cubit.blogsDataModel.data!.paginationInfo.currentPage <
                      cubit.blogsDataModel.data!.paginationInfo.totalPages)
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 40),
                      sliver: SliverToBoxAdapter(
                        child: BlogsShowMore(cubit: cubit),
                      ),
                    ),
                  SliverPadding(padding: const EdgeInsets.only(top: 32)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
