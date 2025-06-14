import '../../../../core/util/dependency_injection.dart';
import '../../../../core/util/localization.dart';
import '../../../../core/widgets/async_retry.dart';
import '../../cubit/shop_cubit.dart';
import 'package:flutter/material.dart';

class ShopErrorView extends StatelessWidget {
  const ShopErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = serviceLocator<ShopCubit>();

    return Center(
      child: AsyncRetryWidget(
        message: localization(
          context,
        ).rpcError(cubit.shopDataModel.error!.code),
        onPressed: () {
          cubit.getShopScreenData();
          cubit.getFilteredProducts();
        },
      ),
    );
  }
}
