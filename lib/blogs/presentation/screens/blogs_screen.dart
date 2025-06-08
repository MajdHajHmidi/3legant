import 'package:e_commerce/blogs/presentation/cubit/blogs_cubit.dart';
import 'package:e_commerce/blogs/presentation/widgets/blogs_appbar.dart';
import 'package:e_commerce/blogs/presentation/widgets/states/blogs_data_view.dart';
import 'package:e_commerce/blogs/presentation/widgets/states/blogs_error_view.dart';
import 'package:e_commerce/blogs/presentation/widgets/states/blogs_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlogsAppbar(),
            Expanded(
              child: BlocBuilder<BlogsCubit, BlogsState>(
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
            ),
          ],
        ),
      ),
    );
  }
}
