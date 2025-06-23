import 'package:e_commerce/core/widgets/app_divider.dart';

import '../../../models/blog_details_data_model.dart';
import '../blog_content_tile.dart';
import '../../../../blogs/presentation/widgets/blogs_grid.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/navigation/router.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/util/date.dart';
import '../../../../core/util/localization.dart';
// ignore: depend_on_referenced_packages
import 'package:sliver_center/sliver_center.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_commerce/blogs/models/blogs_data_model.dart' as blogs_model;
import 'package:go_router/go_router.dart';

class BlogDetailsDataView extends StatelessWidget {
  final BlogDetailsDataModel model;
  const BlogDetailsDataView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverConstrainedCrossAxis(
          maxExtent: 850,
          sliver: SliverCenter(
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(right: 32, left: 32, top: 16),
                  sliver: SliverList.list(
                    children: [
                      Text(
                        model.blogDetails.title,
                        style: AppTextStyles.headline6.copyWith(
                          color: AppColors.neutral_07,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Flexible(
                            child: _buildInfoRow(
                              text: model.blogDetails.publisher,
                              iconPath: AppIcons.profile,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: _buildInfoRow(
                              text: formatDate(model.blogDetails.createdAt),
                              iconPath: AppIcons.calendar,
                              alignment: MainAxisAlignment.end,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      BlogContentTile(
                        content: Content(
                          id: '',
                          text: model.blogDetails.introduction,
                          imageUrl: model.blogDetails.thumbnailUrl,
                          order: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(right: 32, left: 32, top: 16),
                  sliver: SliverList.separated(
                    itemCount: model.content.length,
                    separatorBuilder: (_, _) => SizedBox(height: 16),
                    itemBuilder:
                        (context, index) =>
                            BlogContentTile(content: model.content[index]),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 80, bottom: 24),
                  sliver: SliverToBoxAdapter(child: AppDivider()),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Text(
                          localization(context).youMightAlsoLike,
                          style: AppTextStyles.headline7.copyWith(
                            color: AppColors.neutral_07,
                          ),
                        ),
                      ),
                      SliverPadding(padding: const EdgeInsets.only(top: 40)),
                      BlogsGrid(
                        blogs:
                            model.similarBlogs
                                .map(
                                  (blog) => blogs_model.Blog(
                                    id: blog.id,
                                    categoryId: blog.categoryId,
                                    createdAt: blog.createdAt,
                                    title: blog.title,
                                    publisher: blog.publisher,
                                    thumbnailUrl: blog.thumbnailUrl,
                                    introduction: blog.introduction,
                                    blogCategory:
                                        model.blogDetails.blogCategory ?? '',
                                  ),
                                )
                                .toList(),
                      ),
                      SliverPadding(padding: const EdgeInsets.only(top: 24)),
                      SliverToBoxAdapter(
                        child: Align(
                          alignment: getValueWithDirection(
                            context,
                            Alignment.centerLeft,
                            Alignment.centerRight,
                          ),
                          child: AppTextButton(
                            text: localization(context).moreBlogs,
                            onPressed: () {
                              // In case the nav stack is home -> blogs -> blod_details,
                              // It's ideal to pop instead of pushing a new route

                              final previousRoute =
                                  GoRouter.of(
                                    context,
                                  ).routerDelegate.currentConfiguration.matches;

                              final cameFromBlogsScreen =
                                  previousRoute.length > 1 &&
                                  previousRoute[previousRoute.length - 2]
                                          .matchedLocation ==
                                      AppRoutes.blogs.path;

                              if (cameFromBlogsScreen) {
                                context.pop();
                                return;
                              }

                              context.pushNamed(AppRoutes.blogs.name);
                            },
                          ),
                        ),
                      ),
                      SliverPadding(padding: const EdgeInsets.only(top: 32)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildInfoRow({
  required String text,
  required String iconPath,
  MainAxisAlignment alignment = MainAxisAlignment.start,
}) {
  return Row(
    mainAxisAlignment: alignment,
    children: [
      SvgPicture.asset(
        iconPath,
        // ignore: deprecated_member_use
        color: AppColors.neutral_04,
      ),
      const SizedBox(width: 4),
      Flexible(
        child: Text(
          text,
          style: AppTextStyles.caption2.copyWith(color: AppColors.neutral_04),
        ),
      ),
    ],
  );
}
