import 'package:e_commerce/core/util/app_failure.dart';
import 'package:e_commerce/core/util/supabase_error_handling.dart';
import 'package:e_commerce/home/models/home_data_model.dart';
import 'package:flutter_async_value/async_value.dart';

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
    final response = await supabaseRpc(
      'get_home_screen_data',
      params: {'user_id': userId},
      get: true,
    );

    if (response.isData) {
      return AsyncResult.data(data: HomeDataModel.fromJson(response.data!));
    } else {
      return AsyncResult.error(error: response.error!);
    }
  }
}
