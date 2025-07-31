import '../cubit/blogs_cubit.dart';
import '../../../core/util/localization.dart';
import '../../../core/widgets/app_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsCategoryDropdown extends StatelessWidget {
  final BlogsCubit cubit;
  const BlogsCategoryDropdown({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final model = cubit.blogsDataModel.data!;
    return BlocBuilder<BlogsCubit, BlogsState>(
      bloc: cubit,
      builder: (context, state) {
        return AppDropdownButton<String>(
          value: cubit.categoryId,
          enabled: !cubit.blogsDataModel.isLoading && !cubit.newCategoryLoading,
          width: double.infinity,
          items:
              {}..addEntries(
                model.blogCategories.map(
                  (category) => MapEntry(category.id, category.name),
                ),
              ),
          defaultValue: '',
          defaultText: localization(context).allCategories,
          onChanged: (value) => cubit.changeCategoryId(value ?? ''),
        );
      },
    );
  }
}
