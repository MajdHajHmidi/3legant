import 'package:flutter_async_value/flutter_async_value.dart';

import '../../core/util/app_failure.dart';
import '../../core/util/supabase_error_handling.dart';
import '../models/home_data_model.dart';

abstract class HomeRepo {
  Future<AsyncResult<HomeDataModel, AppFailure>> getHomeData({
    required String userId,
  });
}

class SupabaseHomeRepo extends HomeRepo {
  @override
  Future<AsyncResult<HomeDataModel, AppFailure>> getHomeData({
    required String userId,
  }) async {
    return await supabaseRpc(
      'get_home_screen_data',
      params: {'user_id': userId},
      fromJson: HomeDataModel.fromJson,
      get: true,
    );
  }
}
