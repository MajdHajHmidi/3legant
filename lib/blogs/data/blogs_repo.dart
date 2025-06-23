import '../models/blogs_data_model.dart';
import '../../core/util/app_failure.dart';
import '../../core/util/supabase_error_handling.dart';
import 'package:flutter_async_value/flutter_async_value.dart';

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
    return await supabaseRpc(
      'get_blogs',
      params: {'page': page, 'blog_category_id': blogCategoryId},
      fromJson: BlogsDataModel.fromJson,
      get: true,
    );
  }
}
