import '../cubit/blogs_cubit.dart';
import '../widgets/states/blogs_data_view.dart';
import '../widgets/states/blogs_error_view.dart';
import '../widgets/states/blogs_loading_view.dart';
import '../../../core/util/app_snackbar.dart';
import '../../../core/util/localization.dart';
import '../../../core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: localization(context).blogs),
      body: BlocConsumer<BlogsCubit, BlogsState>(
        listenWhen:
            (_, state) =>
                state is BlogsChangedCategoryErrorState ||
                state is BlogsPaginationErrorState,
        listener: (context, state) {
          if (state is BlogsChangedCategoryErrorState) {
            showErrorSnackBar(
              context,
              localization(context).rpcError(state.failure.code),
            );
          } else if (state is BlogsPaginationErrorState) {
            showErrorSnackBar(
              context,
              localization(context).rpcError(state.failure.code),
            );
          }
        },
        buildWhen: (_, state) => state is BlogsDataChangedState,
        builder: (context, state) {
          final cubit = context.read<BlogsCubit>();

          return AsyncValueBuilder(
            value: cubit.blogsDataModel,
            loading: (context) => BlogsLoadingView(),
            data: (context, data) => BlogsDataView(cubit: cubit),
            error: (context, error) => BlogsErrorView(cubit: cubit),
          );
        },
      ),
    );
  }
}
