import 'package:e_commerce/blogs/presentation/cubit/blogs_cubit.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/async_retry.dart';
import 'package:flutter/material.dart';

class BlogsErrorView extends StatelessWidget {
  final BlogsCubit cubit;
  const BlogsErrorView({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AsyncRetryWidget(
        message: localization(
          context,
        ).rpcError(cubit.blogsDataModel.error!.code),
        onPressed: cubit.getData,
      ),
    );
  }
}
