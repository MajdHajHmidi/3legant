import '../../cubit/blog_details_cubit.dart';
import '../../../../core/util/localization.dart';
import '../../../../core/widgets/async_retry.dart';
import 'package:flutter/material.dart';

class BlogDetailsErrorView extends StatelessWidget {
  final BlogDetailsCubit cubit;
  const BlogDetailsErrorView({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AsyncRetryWidget(
        message: localization(
          context,
        ).rpcError(cubit.blogDetailsModel.error!.code),
        onPressed: () {
          cubit.getBlogDetailsModel(cubit.blogId);
        },
      ),
    );
  }
}
