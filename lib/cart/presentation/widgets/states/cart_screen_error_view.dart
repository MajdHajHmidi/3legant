import 'package:e_commerce/cart/presentation/cubit/cart_screen_data_cubit.dart';

import '../../../../core/util/app_failure.dart';
import '../../../../core/util/localization.dart';
import '../../../../core/widgets/async_retry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreenErrorView extends StatelessWidget {
  final AppFailure failure;
  const CartScreenErrorView({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AsyncRetryWidget(
        message: localization(context).rpcError(failure.code),
        onPressed: () {
          context.read<CartScreenDataCubit>().getCartData();
        },
      ),
    );
  }
}
