import 'package:e_commerce/core/util/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

enum AuthViewMode { signup, signin }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // Default page is signup
  AuthViewMode authViewMode = AuthViewMode.signup;

  void changeViewMode(AuthViewMode mode) {
    authViewMode = mode;

    // * Configurations: Reset Passwords, Reset Privacy Policy Agreement
    signupPasswordFieldController.clear();
    signupConfirmPasswordFieldController.clear();
    signinPasswordFieldController.clear();

    emit(AuthViewModeChangedState());
  }

  final signupFormKey = GlobalKey<FormState>();
  final signinFormKey = GlobalKey<FormState>();
  final nameFieldController = TextEditingController();
  final emailFieldController = TextEditingController();
  final signupPasswordFieldController = TextEditingController();
  final signupConfirmPasswordFieldController = TextEditingController();
  final signinPasswordFieldController = TextEditingController();

  String? validateName(BuildContext context) {
    if (nameFieldController.text.length <= 3) {
      return localization(context).authNameTooShortError;
    }

    return null;
  }

  String? validateEmail(BuildContext context) {
    final email = emailFieldController.text;
    if (email.trim().isEmpty) {
      return localization(context).authEnterEmailError;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email.trim())) {
      return localization(context).authEnterValidEmailError;
    }
    return null;
  }

  String? validateSignupPassword(BuildContext context) {
    final password = signupPasswordFieldController.text;
    if (password.isEmpty) {
      return localization(context).authEnterPasswordError;
    }
    if (password.length < 8) {
      return localization(context).authEnterValidPasswordError;
    }
    return null;
  }

  String? validateSignupPasswordConfirmation(BuildContext context) {
    final password = signupConfirmPasswordFieldController.text;
    if (password.isEmpty) {
      return localization(context).authConfirmPasswordError;
    }
    if (password != signupPasswordFieldController.text) {
      return localization(context).authPasswordsDontMatchError;
    }
    return null;
  }

  String? validateSigninPassword(BuildContext context) {
    final password = signinPasswordFieldController.text;
    if (password.isEmpty) {
      return localization(context).authEnterPasswordError;
    }
    if (password.length < 8) {
      return localization(context).authEnterValidPasswordError;
    }
    return null;
  }

  void signupWithEmailAndPassword(BuildContext context) {
    if (validateName(context) != null ||
        validateEmail(context) != null ||
        validateSignupPassword(context) != null ||
        validateSignupPasswordConfirmation(context) != null ||
        !isPrivacyPolicyAccepted) {
      signupFormKey.currentState?.validate();
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(title: Text('Not Implemented Yet...')),
    );
  }

  void signupWithGoogle(BuildContext context) {
    if (!isPrivacyPolicyAccepted) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(title: Text('Not Implemented Yet...')),
    );
  }

  void signinWithEmailAndPassword(BuildContext context) {
    if (validateEmail(context) != null ||
        validateSigninPassword(context) != null) {
      signinFormKey.currentState?.validate();
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(title: Text('Not Implemented Yet...')),
    );
  }

  void signinWithGoogle(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(title: Text('Not Implemented Yet...')),
    );
  }

  bool isSignupPasswordHidden = true;
  bool isSigninPasswordHidden = true;

  void toggleSignupPasswordVisibility() {
    isSignupPasswordHidden = !isSignupPasswordHidden;
    emit(AuthSignupHidePasswordToggledState());
  }

  void toggleSigninPasswordVisibility() {
    isSigninPasswordHidden = !isSigninPasswordHidden;
    emit(AuthSigninHidePasswordToggledState());
  }

  bool isPrivacyPolicyAccepted = false;
  void togglePrivacyPolicy() {
    isPrivacyPolicyAccepted = !isPrivacyPolicyAccepted;
    emit(AuthPrivacyPolicyToggledState());
  }

  void launchPrivacyPolicyWebpage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(title: Text('Not Implemented Yet...')),
    );
  }

  void launchTermsOfUseWebpage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(title: Text('Not Implemented Yet...')),
    );
  }

  @override
  Future<void> close() {
    nameFieldController.dispose();
    emailFieldController.dispose();
    signupPasswordFieldController.dispose();
    signupConfirmPasswordFieldController.dispose();
    signinPasswordFieldController.dispose();

    return super.close();
  }
}
