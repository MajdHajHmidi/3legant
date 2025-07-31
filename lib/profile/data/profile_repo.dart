import 'package:e_commerce/profile/domain/profile_data_model.dart';
import 'package:flutter_async_value/flutter_async_value.dart';

import '../../core/util/app_failure.dart';
import '../../core/util/supabase_error_handling.dart';

abstract class ProfileRepo {
  Future<AsyncResult<ProfileDataModel, AppFailure>> getHomeData({
    required String userId,
  });

  Future<AsyncResult<void, AppFailure>> changeUsername({
    required String username,
  });
}

class SupabaseProfileRepo extends ProfileRepo {
  @override
  Future<AsyncResult<ProfileDataModel, AppFailure>> getHomeData({
    required String userId,
  }) {
    return supabaseRpc(
      'get_profile_data',
      params: {'user_id': userId},
      fromJson: ProfileDataModel.fromJson,
      get: true,
    );
  }

  @override
  Future<AsyncResult<void, AppFailure>> changeUsername({
    required String username,
  }) {
    return supabaseRpc(
      'update_display_name',
      params: {'new_display_name': username},
    );
  }
}
