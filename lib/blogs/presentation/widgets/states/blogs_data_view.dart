import '../../cubit/blogs_cubit.dart';
import '../blogs_category_dropdown.dart';
import '../blogs_grid.dart';
import '../blogs_header.dart';
import '../blogs_show_more.dart';
import '../../../../core/widgets/app_circular_progress_indicator.dart';
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
                  BlogsGrid(blogs: model.blogs),
                  if (model.paginationInfo.currentPage <
                      model.paginationInfo.totalPages)
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
