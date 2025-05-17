import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/presentation/widgets/auth_screen/auth_header.dart';
import 'package:e_commerce/auth/presentation/widgets/auth_screen/auth_signup_signin_switcher.dart';
import 'package:e_commerce/auth/presentation/widgets/inbox_launcher_tile.dart';
import 'package:e_commerce/core/navigation/router.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (_, state) {
        if (state is AuthEmailSigninSuccessState) {
          // * On Email Signin Success - Go home

          context.goNamed(AppRoutes.home.name);
        } else if (state is AuthEmailSigninErrorState) {
          // * On Email Signin Failure - Show error snackbar

          showAuthErrorSnackbar(context, state.failure.code);
        } else if (state is AuthEmailSignupSuccessState) {
          // * On Email Signup Success - Show dialog

          showSuccessfulSignupDialog(context);
        } else if (state is AuthEmailSignupErrorState) {
          // * On Email Signin Failure - Show error snackbar

          showAuthErrorSnackbar(context, state.failure.code);
        } else if (state is AuthGoogleSigninSuccessState) {
          // * On Google Signin Success - Go home

          context.goNamed(AppRoutes.home.name);
        } else if (state is AuthGoogleSigninErrorState) {
          // * On Google Signin Failure - Show error snackbar

          showAuthErrorSnackbar(context, state.failure.code);
        } else if (state is AuthGoogleSignupSuccessState) {
          // * On Google Signup Success - Go home

          context.goNamed(AppRoutes.home.name);
        } else if (state is AuthGoogleSignupErrorState) {
          // * On Google Signup Failure - Show error snackbar

          showAuthErrorSnackbar(context, state.failure.code);
        }
      },
      child: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return SingleChildScrollView(
                child: SafeArea(
                  bottom: false,
                  right: false,
                  left: false,
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
                Expanded(child: AuthHeader()),
                Expanded(
                  child: SingleChildScrollView(
                    child: BlocProvider.value(
                      value: context.read<AuthCubit>(),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
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

void changeStatusBarColor(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Theme.of(context).brightness,
      statusBarIconBrightness:
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
    ),
  );
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
