import 'package:flutter_async_value/async_value.dart';

import '../data/auth_repo.dart';
import '../../core/util/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepo authRepo;
  ResetPasswordCubit({required this.authRepo}) : super(ResetPasswordInitial());

  final newPasswordController = TextEditingController();
  final newPasswordFormKey = GlobalKey<FormState>();

  bool isPasswordHidden = true;

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    emit(ResetPasswordHidePasswordToggledState());
  }

  String? validateResetPassword(BuildContext context) {
    final password = newPasswordController.text;
    if (password.isEmpty) {
      return localization(context).authEnterPasswordError;
    }
    if (password.length < 8) {
      return localization(context).authEnterValidPasswordError;
    }
    return null;
  }

  AsyncValue resetPasswordModel = AsyncValue.initial();
  void resetPassword(BuildContext context) async {
    if (resetPasswordModel.isLoading) {
      return;
    }

    if (validateResetPassword(context) != null) {
      newPasswordFormKey.currentState?.validate();
      return;
    }

    resetPasswordModel = AsyncValue.loading();
    emit(ResetPasswordRequestDataChangedState());

    final response = await authRepo.updatePassword(
      newPasswordController.text.trim(),
    );

    if (response.isData) {
      resetPasswordModel = AsyncValue.data(data: null);
    } else {
      resetPasswordModel = AsyncValue.error(error: response.error!);
    }

    emit(ResetPasswordRequestDataChangedState());
  }

  @override
  Future<void> close() {
    newPasswordController.dispose();

    return super.close();
  }
}
