import 'package:e_commerce/auth/data/auth_repo.dart';
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:e_commerce/core/util/localization.dart';
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

  bool resetPasswordLoading = false;
  void resetPassword(BuildContext context) async {
    if (resetPasswordLoading) {
      return;
    }

    if (validateResetPassword(context) != null) {
      newPasswordFormKey.currentState?.validate();
      return;
    }

    resetPasswordLoading = true;
    emit(ResetPasswordRequestLoadingState());

    final response = await authRepo.updatePassword(
      newPasswordController.text.trim(),
    );

    resetPasswordLoading = false;

    if (response.isData) {
      emit(ResetPasswordRequestSuccessState());
    } else {
      emit(ResetPasswordRequestFailureState(failure: response.error!));
    }
  }

  @override
  Future<void> close() {
    newPasswordController.dispose();

    return super.close();
  }
}
