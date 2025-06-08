import 'package:e_commerce/blogs/presentation/cubit/blogs_cubit.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
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
        buildWhen:
            (_, state) =>
                state is BlogsPaginationLoadingState ||
                state is BlogsPaginationErrorState ||
                state is BlogsDataChangedState,
        builder: (context, state) {
          return AppRoundedButton.outlined(
            width: 160 * MediaQuery.textScalerOf(context).scale(1),
            text: localization(context).showMore,
            loading: state is BlogsPaginationLoadingState,
            onPressed: () => cubit.getData(isPagination: true),
          );
        },
      ),
    );
  }
}
