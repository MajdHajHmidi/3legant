import 'package:e_commerce/cart/data/cart_repo.dart';
import 'package:e_commerce/cart/models/cart_screen_data_model.dart';
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreenDataCubit
    extends Cubit<AsyncValue<CartScreenDataModel, AppFailure>> {
  final CartRepo _cartRepo;
  CartScreenDataCubit({required CartRepo cartRepo})
    : _cartRepo = cartRepo,
      super(AsyncValue.initial()) {
    getCartData();
  }

  Future<void> getCartData() async {
    if (state.isLoading) return;

    emit(AsyncValue.loading());

    final result = await _cartRepo.getCartData();

    if (result.isData) {
      emit(AsyncValue.data(data: result.data!));
    } else {
      emit(AsyncValue.error(error: result.error!));
    }
  }
}
