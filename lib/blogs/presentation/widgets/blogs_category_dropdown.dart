import 'package:e_commerce/blogs/presentation/cubit/blogs_cubit.dart';
import 'package:e_commerce/core/constants/app_assets.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class BlogsCategoryDropdown extends StatelessWidget {
  final BlogsCubit cubit;
  const BlogsCategoryDropdown({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final model = cubit.blogsDataModel.data!;
    return BlocBuilder<BlogsCubit, BlogsState>(
      bloc: cubit,
      buildWhen: (_, state) => state is BlogsCategoryChangedState,
      builder: (context, state) {
        return Builder(
          builder: (context) {
            final border = OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.neutral_04, width: 2),
            );
            return DropdownButtonFormField(
              value: cubit.categoryId,
              borderRadius: BorderRadius.circular(8),
              decoration: InputDecoration(
                border: border,
                enabledBorder: border,
                focusedBorder: border,
                disabledBorder: border,
              ),
              style: AppTextStyles.body2Semi.copyWith(
                color: AppColors.neutral_06,
              ),
              icon: SvgPicture.asset(
                AppIcons.dropdown,
                theme: SvgTheme(currentColor: AppColors.neutral_04),
              ),
              selectedItemBuilder:
                  (context) =>
                      [
                            localization(context).allCategories,
                            ...model.blogCategories.map(
                              (category) => category.name,
                            ),
                          ]
                          .map(
                            (value) => Center(
                              child: Text(
                                value,
                                textScaler: TextScaler.linear(1),
                              ),
                            ),
                          )
                          .toList(),
              items: [
                DropdownMenuItem(
                  value: '',
                  child: Text(localization(context).allCategories),
                ),
                ...model.blogCategories.map(
                  (category) => DropdownMenuItem(
                    value: category.id,
                    child: Text(category.name),
                  ),
                ),
              ],
              onChanged: (value) => cubit.changeCategoryId(value ?? ''),
            );
          },
        );
      },
    );
  }
}
