import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/presentation/widgets/auth_screen/auth_header.dart';
import 'package:e_commerce/auth/presentation/widgets/auth_screen/auth_signup_signin_switcher.dart';
import 'package:e_commerce/core/navigation/router.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    context.read<AuthCubit>().initDeepLinking(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (_, state) {
        if (state is AuthEmailSigninSuccessState) {
          context.goNamed(AppRoutes.home.name);
        } else if (state is AuthEmailSigninErrorState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          showErrorSnackBar(
            context,
            localization(context).authEmailSigninError('${state.statusCode}'),
          );
        } else if (state is AuthEmailSignupSuccessState) {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: Text(localization(context).authVerifyEmailDialogTitle),
                  content: Text(
                    localization(context).authVerifyEmailDialogContent,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );
        } else if (state is AuthEmailSignupErrorState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          showErrorSnackBar(
            context,
            localization(context).authEmailSignupError('${state.statusCode}'),
          );
        } else if (state is AuthGoogleSigninSuccessState) {
          context.goNamed(AppRoutes.home.name);
        } else if (state is AuthGoogleSigninErrorState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          showErrorSnackBar(
            context,
            localization(context).authGoogleSigninError('${state.statusCode}'),
          );
        } else if (state is AuthGoogleSignupSuccessState) {
          context.goNamed(AppRoutes.home.name);
        } else if (state is AuthGoogleSignupErrorState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          showErrorSnackBar(
            context,
            localization(context).authGoogleSignupError('${state.statusCode}'),
          );
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
