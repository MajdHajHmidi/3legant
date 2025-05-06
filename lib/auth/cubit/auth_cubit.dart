import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:e_commerce/auth/data/auth_repo.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

enum AuthViewMode { signup, signin }

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  late final StreamSubscription deepLinkStreamSub;
  void initDeepLinking(BuildContext context) {
    deepLinkStreamSub = AppLinks().uriLinkStream.listen((link) {
      // No extra configuration needed for email verification deep linking,
      // Supabase SDK will take care of verifying exchanging the code for the session
    });
  }

  // Default page is signup
  AuthViewMode authViewMode = AuthViewMode.signup;
  void changeViewMode(AuthViewMode mode) {
    authViewMode = mode;

    // * Configurations: Reset Passwords, Reset Privacy Policy Agreement
    signupPasswordFieldController.clear();
    signupConfirmPasswordFieldController.clear();
    signinPasswordFieldController.clear();

    isPrivacyPolicyAccepted = false;
    emit(AuthPrivacyPolicyToggledState());

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

  bool emailSignupLoading = false;
  void signupWithEmailAndPassword(BuildContext context) async {
    if (emailSignupLoading) {
      return;
    }

    if (validateName(context) != null ||
        validateEmail(context) != null ||
        validateSignupPassword(context) != null ||
        validateSignupPasswordConfirmation(context) != null ||
        !isPrivacyPolicyAccepted) {
      signupFormKey.currentState?.validate();
      return;
    }

    emit(AuthEmailSignupLoadingState());
    emailSignupLoading = true;
    final statusCode = await authRepo.signupWithEmailAndPassword(
      email: emailFieldController.text.trim(),
      password: signupPasswordFieldController.text.trim(),
      name: nameFieldController.text.trim(),
    );

    emailSignupLoading = false;
    if (statusCode == 200) {
      emit(AuthEmailSignupSuccessState());
    } else {
      emit(AuthEmailSignupErrorState(statusCode: statusCode));
    }
  }

  bool googleSignupLoading = false;
  void signupWithGoogle(BuildContext context) async {
    if (!isPrivacyPolicyAccepted) {
      return;
    }

    if (googleSignupLoading) {
      return;
    }

    googleSignupLoading = true;
    emit(AuthGoogleSignupLoadingState());

    final statusCode = await authRepo.signupWithGoogle(
      Theme.of(context).platform,
    );

    googleSignupLoading = false;

    if (statusCode == 200) {
      emit(AuthGoogleSignupSuccessState());
    } else {
      emit(AuthGoogleSignupErrorState(statusCode: statusCode));
    }
  }

  bool emailSignInLoading = false;
  void signinWithEmailAndPassword(BuildContext context) async {
    if (emailSignInLoading) {
      return;
    }

    if (validateEmail(context) != null ||
        validateSigninPassword(context) != null) {
      signinFormKey.currentState?.validate();
      return;
    }

    emit(AuthEmailSigninLoadingState());
    emailSignInLoading = true;
    final statusCode = await authRepo.signinWithEmailAndPassword(
      email: emailFieldController.text.trim(),
      password: signinPasswordFieldController.text.trim(),
    );

    emailSignInLoading = false;
    if (statusCode == 200) {
      emit(AuthEmailSigninSuccessState());
    } else {
      emit(AuthEmailSigninErrorState(statusCode: statusCode));
    }
  }

  bool googleSignInLoading = false;
  void signinWithGoogle(BuildContext context) async {
    if (googleSignInLoading) {
      return;
    }

    googleSignInLoading = true;
    emit(AuthGoogleSigninLoadingState());

    final statusCode = await authRepo.signinWithGoogle(
      Theme.of(context).platform,
    );

    googleSignInLoading = false;

    if (statusCode == 200) {
      emit(AuthGoogleSigninSuccessState());
    } else {
      emit(AuthGoogleSigninErrorState(statusCode: statusCode));
    }
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

    deepLinkStreamSub.cancel();

    return super.close();
  }
}
