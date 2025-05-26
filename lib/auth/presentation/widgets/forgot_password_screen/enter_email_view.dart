import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/util/localization.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_textfield.dart';
import '../../../cubit/auth_cubit.dart';

class EnterEmailView extends StatelessWidget {
  const EnterEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localization(context).authForgotPasswordEnterEmailTitle,
          style: AppTextStyles.body2Semi.copyWith(
            color: AppColors.neutral_06,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          localization(context).authForgotPasswordEnterEmailSubtitle,
          style: AppTextStyles.caption2.copyWith(color: AppColors.neutral_04),
        ),
        const SizedBox(height: 40),
        Form(
          key: cubit.forgotPasswordEmailFormKey,
          child: AppTextFormField(
            hint: localization(context).authFieldEmail,
            controller: cubit.emailFieldController,
            textInputAction: TextInputAction.done,
            validator: (value) => cubit.validateEmail(context),
            onFieldSubmitted:
                (value) => cubit.requestPasswordResetEmail(context),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        const Spacer(),
        BlocConsumer<AuthCubit, AuthState>(
          listenWhen:
              (_, state) =>
                  state is AuthPasswordResetEmailRequestDataChangedState,
          listener: (context, state) {
            if (state is AuthPasswordResetEmailRequestDataChangedState) {
              if (cubit.passwordResetRequestModel.isData) {
                context.read<AuthCubit>().changeForgotPasswordPage(
                  ForgotPasswordViewMode.checkInbox,
                );
              }
            }
          },
          buildWhen:
              (_, state) =>
                  state is AuthPasswordResetEmailRequestDataChangedState,
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();

            return AppButton(
              text: localization(context).authForgotPasswordRequestButton,
              loading: cubit.passwordResetRequestModel.isLoading,
              onPressed: () => cubit.requestPasswordResetEmail(context),
            );
          },
        ),
      ],
    );
  }
}
