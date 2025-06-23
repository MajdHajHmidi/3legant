import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/util/app_failure.dart';

abstract class FavoriteRepo {
  Future<AsyncResult<void, AppFailure>> toggleFavorite({
    required String userId,
    required String productId,
  });
}

class SupabaseFavoriteRepo extends FavoriteRepo {
  @override
  Future<AsyncResult<void, AppFailure>> toggleFavorite({
    required String userId,
    required String productId,
  }) async {
    try {
      await Supabase.instance.client.rpc(
        'toggle_favorite',
        params: {'user_id': userId, 'product_id': productId},
      );

      return AsyncResult.data(data: null);
    } catch (_) {
      return AsyncResult.error(
        error: NetworkFailure(code: RpcFailureCodes.other.name),
      );
    }
  }
}
