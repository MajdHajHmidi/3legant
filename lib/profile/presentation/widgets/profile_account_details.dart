import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:e_commerce/core/util/app_snackbar.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_textfield.dart';
import 'package:e_commerce/profile/application/profile_controller.dart';
import 'package:e_commerce/profile/domain/profile_data_model.dart';
import 'package:e_commerce/profile/presentation/cubits/profile_details_update_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAccountDetails extends StatelessWidget {
  final AccountDetails accountDetails;
  const ProfileAccountDetails({super.key, required this.accountDetails});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localization(context).yourName.toUpperCase(),
            style: AppTextStyles.hairline2.copyWith(
              color: AppColors.neutral_04,
            ),
          ),
          SizedBox(height: 12),
          AppTextFormField.outlineBorder(
            controller:
                context.read<ProfileController>().profileNameTextController
                  ..text = accountDetails.displayName,
            hint: localization(context).yourName,
            borderRadius: 6,
          ),
          SizedBox(height: 24),
          Text(
            localization(context).email.toUpperCase(),
            style: AppTextStyles.hairline2.copyWith(
              color: AppColors.neutral_04,
            ),
          ),
          SizedBox(height: 12),
          AppTextFormField.outlineBorder(
            controller: TextEditingController(text: accountDetails.email),
            hint: localization(context).email,
            readOnly: true,
            borderRadius: 6,
          ),
          SizedBox(height: 36),
          BlocConsumer<
            ProfileDetailsUpdateCubit,
            AsyncValue<String, AppFailure>
          >(
            listener: (context, state) {
              if (state.isData) {
                showSuccessSnackBar(
                  context,
                  localization(context).accountUpdatedSuccessfully,
                );
              } else if (state.isError) {
                showErrorSnackBar(
                  context,
                  localization(context).rpcError(state.error!.code),
                );
              }
            },
            builder: (context, state) {
              return SecondaryAppButton(
                text: localization(context).saveChanges,
                loading: state.isLoading,
                onPressed:
                    context.read<ProfileController>().updateAccountDetails,
              );
            },
          ),
        ],
      ),
    );
  }
}
