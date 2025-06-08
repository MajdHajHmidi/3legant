import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/router.dart';
import '../../../core/widgets/app_circular_progress_indicator.dart';
import '../cubit/login_callback_cubit.dart';

class LoginCallbackScreen extends StatelessWidget {
  const LoginCallbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCallbackCubit, LoginCallbackState>(
      listenWhen:
          (_, state) =>
              state is LoginCallbackSuccessState ||
              state is LoginCallbackFailureState,
      listener: (context, state) {
        if (state is LoginCallbackSuccessState) {
          context.goNamed(AppRoutes.home.name);
        } else if (state is LoginCallbackFailureState) {
          context.goNamed(AppRoutes.home.name);
        }
      },
      child: Scaffold(
        body: Center(
          child: AppCircularProgressIndicator(),
        ),
      ),
    );
  }
}
