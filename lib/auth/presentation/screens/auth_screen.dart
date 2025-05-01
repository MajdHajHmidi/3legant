import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/presentation/widgets/auth_screen/auth_header.dart';
import 'package:e_commerce/auth/presentation/widgets/auth_screen/auth_signup_signin_switcher.dart';
import 'package:e_commerce/core/util/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        mobile:
            (context) => SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AuthHeader(),
                  BlocProvider.value(
                    value: context.read<AuthCubit>(),
                    child: Flexible(child: AuthSignupSigninSwitcher()),
                  ),
                ],
              ),
            ),
        tablet:
            (context) => Row(
              children: [
                Flexible(child: AuthHeader()),
                Expanded(
                  child: SingleChildScrollView(
                    child: BlocProvider.value(
                      value: context.read<AuthCubit>(),
                      child: SafeArea(child: AuthSignupSigninSwitcher()),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
