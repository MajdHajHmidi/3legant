import '../models/blogs_data_model.dart';
import '../../core/util/app_failure.dart';
import '../../core/util/supabase_error_handling.dart';
import 'package:flutter_async_value/async_value.dart';

abstract class BlogsRepo {
  Future<AsyncResult<BlogsDataModel, AppFailure>> getBlogs({
    required int page,
    required String blogCategoryId,
  });
}

class SupabaseBlogsRepo extends BlogsRepo {
  @override
  Future<AsyncResult<BlogsDataModel, AppFailure>> getBlogs({
    required int page,
    required String blogCategoryId,
  }) async {
    final response = await supabaseRpc(
      'get_blogs',
      params: {'page': page, 'blog_category_id': blogCategoryId},
      get: true,
    );

    if (response.isData) {
      return AsyncResult.data(data: BlogsDataModel.fromJson(response.data!));
    } else {
      return AsyncResult.error(error: response.error!);
    }
  }
}
