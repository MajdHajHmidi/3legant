import 'package:e_commerce/cart/data/cart_repo.dart';
import 'package:e_commerce/cart/models/coupon.dart';
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// If coupon is null, no coupon is applied
class CouponCubit extends Cubit<AsyncValue<Coupon?, AppFailure>> {
  final CartRepo _cartRepo;
  // Default state: no coupon applied
  CouponCubit({required CartRepo cartRepo})
    : _cartRepo = cartRepo,
      super(AsyncValue.data(data: null));

  Future<void> applyCoupon({required String couponName}) async {
    if (couponName.isEmpty || state.isLoading) return;

    emit(AsyncValue.loading());

    final result = await _cartRepo.applyCoupon(couponName: couponName);

    if (result.isData) {
      emit(AsyncValue.data(data: result.data!));
    } else {
      emit(AsyncValue.error(error: result.error!));
    }
  }
}
