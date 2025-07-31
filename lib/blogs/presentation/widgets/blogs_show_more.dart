import '../cubit/blogs_cubit.dart';
import '../../../core/util/localization.dart';
import '../../../core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsShowMore extends StatelessWidget {
  final BlogsCubit cubit;
  const BlogsShowMore({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<BlogsCubit, BlogsState>(
        bloc: cubit,
        buildWhen: (_, state) => state is BlogsDataChangedState,
        builder: (context, state) {
          final cubit = context.read<BlogsCubit>();

          return AppRoundedButton.outlined(
            width: 160 * MediaQuery.textScalerOf(context).scale(1),
            text: localization(context).showMore,
            loading: cubit.blogsDataModel.isLoadingPage,
            onPressed:
                () => cubit.getBlogs(
                  page:
                      cubit.blogsDataModel.data!.paginationInfo.currentPage + 1,
                ),
          );
        },
      ),
    );
  }
}
