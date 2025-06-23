import '../cubit/blog_details_cubit.dart';
import '../widgets/states/blog_details_data_view.dart';
import '../widgets/states/blog_details_error_view.dart';
import '../widgets/states/blog_details_loading_view.dart';
import '../../../core/util/localization.dart';
import '../../../core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogDetailsScreen extends StatelessWidget {
  const BlogDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: localization(context).blogs),
      body: BlocBuilder<BlogDetailsCubit, BlogDetailsState>(
        buildWhen: (_, state) => state is BlogDetailsDataChangedState,
        builder: (context, state) {
          final cubit = context.read<BlogDetailsCubit>();
          return AsyncValueBuilder(
            value: cubit.blogDetailsModel,
            loading: (context) => BlogDetailsLoadingView(),
            data: (context, data) => BlogDetailsDataView(model: data),
            error: (context, error) => BlogDetailsErrorView(cubit: cubit),
          );
        },
      ),
    );
  }
}
