import 'package:e_commerce/core/navigation/router.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:e_commerce/core/util/app_snackbar.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/app_circular_progress_indicator.dart';
import 'package:e_commerce/core/widgets/custom_app_bar.dart';
import 'package:e_commerce/profile/domain/profile_data_model.dart';
import 'package:e_commerce/profile/presentation/cubits/profile_screen_data_cubit.dart';
import 'package:e_commerce/profile/presentation/cubits/profile_signout_cubit.dart';
import 'package:e_commerce/profile/presentation/widgets/states/profile_data_view.dart';
import 'package:e_commerce/profile/presentation/widgets/states/profile_error_view.dart';
import 'package:e_commerce/profile/presentation/widgets/states/profile_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: localization(context).yourProfile,
        leadingIconAction: () {
          // Close the keybaord if already opened
          FocusScope.of(context).unfocus();
          context.goNamed(AppRoutes.home.name);
        },
        trailingIcon:
            BlocConsumer<ProfileSignoutCubit, AsyncValue<void, AppFailure>>(
              listener: (context, state) {
                if (state.isError) {
                  showErrorSnackBar(
                    context,
                    localization(context).signoutFailure,
                  );
                } else if (state.isData) {
                  context.goNamed(AppRoutes.auth.name);
                }
              },
              builder: (context, state) {
                if (state.isLoading) {
                  return AppCircularProgressIndicator();
                }

                return Icon(Icons.logout, color: AppColors.neutral_07);
              },
            ),
        trailingIconAction: context.read<ProfileSignoutCubit>().signOut,
      ),
      body: BlocBuilder<
        ProfileScreenDataCubit,
        AsyncValue<ProfileDataModel, AppFailure>
      >(
        builder: (context, state) {
          return AsyncValueBuilder(
            value: state,
            loading: (context) => ProfileLoadingView(),
            data: (context, data) => ProfileDataView(screenDataModel: data),
            error: (context, error) => ProfileErrorView(failure: error),
          );
        },
      ),
    );
  }
}
