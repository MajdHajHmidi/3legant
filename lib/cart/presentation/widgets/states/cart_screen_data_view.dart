import 'package:e_commerce/cart/presentation/widgets/cart_view_mode_indicator.dart';
import 'package:flutter/material.dart';

class CartScreenDataView extends StatelessWidget {
  const CartScreenDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          CartViewModeIndicator(),
          SizedBox(height: 40),
          
        ],
      ),
    );
  }
}


// Text(
//   'Products in cart: ${context.read<CartScreenDataCubit>().state.data!.products.length}',
// ),
// SizedBox(height: 80),
// AppTextFormField(
//   hint: 'Coupon....',
//   onFieldSubmitted:
//       (value) => context.read<CouponCubit>().applyCoupon(
//         couponName: value,
//       ),
// ),
// SizedBox(height: 30),
// BlocBuilder<CouponCubit, AsyncValue<Coupon?, AppFailure>>(
//   builder: (context, state) {
//     return AsyncValueBuilder(
//       value: state,
//       loading: (_) => AppCircularProgressIndicator(),
//       data:
//           (context, data) => Text(
//             data == null
//                 ? 'No Coupon'
//                 : data.discount.toString(),
//           ),
//       error: (context, error) => Text(error.code),
//     );
//   },
// ),
// AppButton(
//   text: 'First',
//   onPressed:
//       () => context.read<CartViewModeCubit>().changeViewMode(
//         CartViewMode.shoppingCart,
//       ),
// ),
// AppButton(
//   text: 'Second',
//   onPressed:
//       () => context.read<CartViewModeCubit>().changeViewMode(
//         CartViewMode.checkoutDetails,
//       ),
// ),
// AppButton(
//   text: 'Third',
//   onPressed:
//       () => context.read<CartViewModeCubit>().changeViewMode(
//         CartViewMode.orderComplete,
//       ),
// ),