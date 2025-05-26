import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/router.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/util/app_snackbar.dart';
import '../../../core/util/localization.dart';
import '../../cubit/auth_cubit.dart';
import '../widgets/auth_screen/auth_header.dart';
import '../widgets/auth_screen/auth_signup_signin_switcher.dart';
import '../widgets/inbox_launcher_tile.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (_, state) {
        final cubit = context.read<AuthCubit>();

        if (state is AuthEmailSigninDataChangedState) {
          if (cubit.emailSigninModel.isData) {
            // * On Email Signin Success - Go home
            context.goNamed(AppRoutes.home.name);
          } else if (cubit.emailSigninModel.isError) {
            // * On Email Signin Failure - Show error snackbar
            showAuthErrorSnackbar(context, cubit.emailSigninModel.error!.code);
          }
        } else if (state is AuthEmailSignupDataChangedState) {
          if (cubit.emailSignupModel.isData) {
            // * On Email Signup Success - Show dialog
            showSuccessfulSignupDialog(context);
          } else if (cubit.emailSignupModel.isError) {
            // * On Email Signup Failure - Show error snackbar
            showAuthErrorSnackbar(context, cubit.emailSignupModel.error!.code);
          }
        } else if (state is AuthGoogleSigninDataChangedState) {
          if (cubit.googleSigninModel.isData) {
            // * On Google Signin Success - Go home
            context.goNamed(AppRoutes.home.name);
          } else if (cubit.googleSigninModel.isError) {
            // * On Google Signin Failure - Show error snackbar
            showAuthErrorSnackbar(context, cubit.googleSigninModel.error!.code);
          }
        } else if (state is AuthGoogleSignupDataChangedState) {
          if (cubit.googleSignupModel.isData) {
            // * On Google Signup Success - Go home
            context.goNamed(AppRoutes.home.name);
          } else if (cubit.googleSignupModel.isError) {
            // * On Google Signup Failure - Show error snackbar

            showAuthErrorSnackbar(context, cubit.googleSignupModel.error!.code);
          }
        }
      },
      child: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Allow the header to take up half of the screen's height
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.5,
                        child: AuthHeader(),
                      ),
                      BlocProvider.value(
                        value: context.read<AuthCubit>(),
                        child: Flexible(child: AuthSignupSigninSwitcher()),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      child: AuthHeader(),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: SingleChildScrollView(
                      child: BlocProvider.value(
                        value: context.read<AuthCubit>(),
                        child: AuthSignupSigninSwitcher(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

void showSuccessfulSignupDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (_) => Align(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 450),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          localization(context).authVerifyEmailDialogTitle,
                          style: AppTextStyles.body1Semi.copyWith(
                            color: AppColors.neutral_06,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      localization(context).authVerifyEmailDialogContent,
                      style: AppTextStyles.caption2.copyWith(
                        color: AppColors.neutral_04,
                      ),
                    ),
                    const SizedBox(height: 16),
                    InboxLauncherTile.small(),
                  ],
                ),
              ),
            ),
          ),
        ),
  );
}

void showAuthErrorSnackbar(BuildContext context, String errorCode) {
  showErrorSnackBar(context, localization(context).authError(errorCode));
}
