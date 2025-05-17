import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/presentation/widgets/forgot_password_screen/check_inbox_view.dart';
import 'package:e_commerce/auth/presentation/widgets/forgot_password_screen/enter_email_view.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/util/snackbar.dart';
import 'package:e_commerce/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthForgotPassword extends StatelessWidget {
  const AuthForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthPasswordResetEmailRequestFailureState) {
          // ! On Email Request Failure
          showErrorSnackBar(
            context,
            localization(context).authError(state.failure.code),
          );
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          onBackPressed(context, cubit);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            text: localization(context).authForgotPasswordTitle,
            leadingIconAction: () => onBackPressed(context, cubit),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 32),
            child: PageView(
              controller: cubit.forgotPasswordScreenPageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                BlocProvider.value(value: cubit, child: EnterEmailView()),
                BlocProvider.value(value: cubit, child: CheckInboxView()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void onBackPressed(BuildContext context, AuthCubit cubit) {
  final page = cubit.forgotPasswordViewMode.pageIndex;

  if (page == 0) {
    context.pop();
  } else {
    // Animate to the previous page
    cubit.changeForgotPasswordPage(
      ForgotPasswordViewMode.values.firstWhere(
        (mode) => mode.pageIndex == cubit.forgotPasswordViewMode.pageIndex - 1,
      ),
    );
  }
}
