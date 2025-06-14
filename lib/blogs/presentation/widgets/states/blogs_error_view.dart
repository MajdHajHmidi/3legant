import '../../cubit/blogs_cubit.dart';
import '../../../../core/util/localization.dart';
import '../../../../core/widgets/async_retry.dart';
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
