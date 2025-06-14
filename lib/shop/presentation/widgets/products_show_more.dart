import '../../../core/util/dependency_injection.dart';
import '../../../core/util/localization.dart';
import '../../../core/widgets/app_button.dart';
import '../cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsShowMore extends StatelessWidget {
  const ProductsShowMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ShopCubit, ShopState>(
        bloc: serviceLocator<ShopCubit>(),
        builder: (context, state) {
          final cubit = serviceLocator<ShopCubit>();

          return AppRoundedButton.outlined(
            width: 160 * MediaQuery.textScalerOf(context).scale(1),
            text: localization(context).showMore,
            loading: cubit.paginationLoading,
            onPressed: () => cubit.getFilteredProducts(isPagination: true),
          );
        },
      ),
    );
  }
}
