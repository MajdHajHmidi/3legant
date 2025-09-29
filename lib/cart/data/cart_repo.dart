import 'package:e_commerce/cart/models/cart_screen_data_model.dart';
import 'package:e_commerce/cart/models/coupon.dart';
import 'package:flutter_async_value/flutter_async_value.dart';

import '../../core/util/app_failure.dart';
import '../../core/util/supabase_error_handling.dart';

abstract class CartRepo {
  Future<AsyncResult<CartScreenDataModel, AppFailure>> getCartData();
  Future<AsyncResult<Coupon, AppFailure>> applyCoupon({
    required String couponName,
  });
}

class SupabaseCartRepo extends CartRepo {
  @override
  Future<AsyncResult<CartScreenDataModel, AppFailure>> getCartData() async {
    return await supabaseRpc(
      'get_billing_screen_data',
      fromJson: CartScreenDataModel.fromJson,
    );
  }

  @override
  Future<AsyncResult<Coupon, AppFailure>> applyCoupon({
    required String couponName,
  }) async {
    return await supabaseRpc(
      'get_coupon_by_name',
      params: {'coupon_name': couponName},
      fromJson: Coupon.fromJson,
      get: true,
    );
  }
}
