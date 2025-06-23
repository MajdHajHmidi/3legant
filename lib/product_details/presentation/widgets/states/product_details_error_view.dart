import 'package:e_commerce/auth/data/auth_repo.dart';
import 'package:e_commerce/core/util/dependency_injection.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/async_retry.dart';
import 'package:e_commerce/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsErrorView extends StatelessWidget {
  const ProductDetailsErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    return Center(
      child: AsyncRetryWidget(
        message: localization(
          context,
        ).rpcError(cubit.productDetailsModel.error!.code),
        onPressed: () {
          final userId = serviceLocator<AuthRepo>().getCurrentUser()?.id;

          if (userId != null) {
            cubit.getProductDetails(userId: userId, productId: cubit.productId);
          }
        },
      ),
    );
  }
}
