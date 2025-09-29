import 'package:e_commerce/core/util/app_snackbar.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/custom_app_bar.dart';
import 'package:e_commerce/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:e_commerce/product_details/presentation/widgets/states/product_details_data_view.dart';
import 'package:e_commerce/product_details/presentation/widgets/states/product_details_error_view.dart';
import 'package:e_commerce/product_details/presentation/widgets/states/product_details_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  /// Used to display product name before making request to backend
  final String productName;
  const ProductDetailsScreen({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: productName),
      body: SafeArea(
        child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
          listenWhen:
              (_, state) =>
                  state is ProductReviewsDataChangedState ||
                  state is ProductDetailsReviewDataChangedState,
          listener: (context, state) {
            final cubit = context.read<ProductDetailsCubit>();

            if (state is ProductReviewsDataChangedState) {
              if (cubit.productReviewsModel.hasPageError) {
                showErrorSnackBar(
                  context,
                  localization(
                    context,
                  ).rpcError(cubit.productReviewsModel.error!.code),
                );
              }
            } else if (state is ProductDetailsReviewDataChangedState) {
              if (cubit.userReviewSubmitModel.isError) {
                showErrorSnackBar(
                  context,
                  localization(
                    context,
                  ).rpcError(cubit.userReviewSubmitModel.error!.code),
                );
              } else if (cubit.userReviewSubmitModel.isData) {
                showSuccessSnackBar(
                  context,
                  localization(context).productReviewSubmitted,
                );
              }
            }
          },
          builder: (context, state) {
            final cubit = context.read<ProductDetailsCubit>();

            return AsyncValueBuilder(
              value: cubit.productDetailsModel,
              loading: (context) => ProductDetailsLoadingView(),
              data:
                  (context, data) => BlocProvider.value(
                    value: cubit,
                    child: ProductDetailsDataView(),
                  ),
              error: (context, error) => ProductDetailsErrorView(),
            );
          },
        ),
      ),
    );
  }
}
