import 'package:flutter_bloc/flutter_bloc.dart';

enum CartViewMode { shoppingCart, checkoutDetails, orderComplete }

class CartViewModeCubit extends Cubit<CartViewMode> {
  CartViewModeCubit() : super(CartViewMode.shoppingCart);

  void changeViewMode(CartViewMode mode) {
    emit(mode);
  }
}
