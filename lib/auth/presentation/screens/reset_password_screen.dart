import 'package:e_commerce/auth/cubit/reset_password_cubit.dart';
import 'package:e_commerce/core/constants/app_assets.dart';
import 'package:e_commerce/core/navigation/router.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/util/snackbar.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_textfield.dart';
import 'package:e_commerce/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResetPasswordCubit>();

    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordRequestFailureState) {
          // ! On Password Reset Failure
          showErrorSnackBar(
            context,
            localization(context).authError(state.failure.code),
          );
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          context.goNamed(AppRoutes.home.name);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            text: localization(context).authForgotPasswordTitle,
            leadingIconAction: () => context.goNamed(AppRoutes.home.name),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localization(context).authForgotPasswordSetPasswordTitle,
                  style: AppTextStyles.body2Semi.copyWith(
                    color: AppColors.neutral_06,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  localization(context).authForgotPasswordSetPasswordSubtitle,
                  style: AppTextStyles.caption2.copyWith(
                    color: AppColors.neutral_04,
                  ),
                ),
                const SizedBox(height: 40),
                Form(
                  key: cubit.newPasswordFormKey,
                  child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                    buildWhen:
                        (_, state) =>
                            state is ResetPasswordHidePasswordToggledState,
                    builder: (context, state) {
                      final cubit = context.read<ResetPasswordCubit>();

                      return AppTextFormField(
                        hint: localization(context).authFieldPassword,
                        controller: cubit.newPasswordController,
                        textInputAction: TextInputAction.done,
                        validator:
                            (value) => cubit.validateResetPassword(context),
                        onFieldSubmitted:
                            (value) => cubit.resetPassword(context),
                        obscure: cubit.isPasswordHidden,
                        suffixIcon: Container(
                          width: 26,
                          height: 26,
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(
                            cubit.isPasswordHidden
                                ? AppIcons.eye
                                : AppIcons.strikedEye,
                            theme: SvgTheme(currentColor: AppColors.neutral_04),
                            width: 26,
                            height: 26,
                          ),
                        ),
                        onSuffixIconPressed: cubit.togglePasswordVisibility,
                      );
                    },
                  ),
                ),
                const Spacer(),
                BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                  listenWhen:
                      (_, state) => state is ResetPasswordRequestSuccessState,
                  listener: (context, state) {
                    if (state is ResetPasswordRequestSuccessState) {
                      context.goNamed(AppRoutes.home.name);
                    }
                  },
                  buildWhen:
                      (_, state) =>
                          state is ResetPasswordRequestLoadingState ||
                          state is ResetPasswordRequestSuccessState ||
                          state is ResetPasswordRequestFailureState,
                  builder: (context, state) {
                    final cubit = context.read<ResetPasswordCubit>();

                    return AppButton(
                      text:
                          localization(
                            context,
                          ).authForgotPasswordSetPasswordButton,
                      loading: cubit.resetPasswordLoading,
                      onPressed: () => cubit.resetPassword(context),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
