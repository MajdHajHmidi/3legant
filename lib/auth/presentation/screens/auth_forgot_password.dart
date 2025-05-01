import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthForgotPassword extends StatelessWidget {
  const AuthForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(localization(context).authForgotPasswordTitle)),
      body: SafeArea(
        child: Text(context.read<AuthCubit>().emailFieldController.text),
      ),
    );
  }
}
