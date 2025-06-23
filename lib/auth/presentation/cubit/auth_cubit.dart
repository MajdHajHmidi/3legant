import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/util/app_failure.dart';
import '../../../core/util/duration_extension.dart';
import '../../../core/util/localization.dart';
import '../../data/auth_repo.dart';

part 'auth_state.dart';

enum AuthViewMode { signup, signin }

enum ForgotPasswordViewMode {
  enterEmail(pageIndex: 0),
  checkInbox(pageIndex: 1);

  const ForgotPasswordViewMode({required this.pageIndex});
  final int pageIndex;
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  AuthCubit({required AuthRepo authRepo})
    : _authRepo = authRepo,
      super(AuthInitial());

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

  AsyncValue<void, AppFailure> emailSignupModel = AsyncValue.initial();
  void signupWithEmailAndPassword(BuildContext context) async {
    if (emailSignupModel.isLoading) {
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

    emailSignupModel = AsyncValue.loading();
    emit(AuthEmailSignupDataChangedState());
    final response = await _authRepo.signupWithEmailAndPassword(
      email: emailFieldController.text.trim(),
      password: signupPasswordFieldController.text.trim(),
      name: nameFieldController.text.trim(),
    );

    if (response.isData) {
      emailSignupModel = AsyncValue.data(data: null);
    } else {
      emailSignupModel = AsyncValue.error(error: response.error!);
    }

    emit(AuthEmailSignupDataChangedState());
  }

  AsyncValue<void, AppFailure> googleSignupModel = AsyncValue.initial();
  void signupWithGoogle(BuildContext context) async {
    if (!isPrivacyPolicyAccepted) {
      return;
    }

    if (googleSignupModel.isLoading) {
      return;
    }

    googleSignupModel = AsyncValue.loading();
    emit(AuthGoogleSignupDataChangedState());

    final response = await _authRepo.signupWithGoogle(
      Theme.of(context).platform,
    );

    if (response.isData) {
      googleSignupModel = AsyncValue.data(data: null);
    } else {
      googleSignupModel = AsyncValue.error(error: response.error!);
    }

    emit(AuthGoogleSignupDataChangedState());
  }

  AsyncValue<void, AppFailure> emailSigninModel = AsyncValue.initial();
  void signinWithEmailAndPassword(BuildContext context) async {
    if (emailSigninModel.isLoading) {
      return;
    }

    if (validateEmail(context) != null ||
        validateSigninPassword(context) != null) {
      signinFormKey.currentState?.validate();
      return;
    }

    emailSigninModel = AsyncValue.loading();
    emit(AuthEmailSigninDataChangedState());

    final response = await _authRepo.signinWithEmailAndPassword(
      email: emailFieldController.text.trim(),
      password: signinPasswordFieldController.text.trim(),
    );

    if (response.isData) {
      emailSigninModel = AsyncValue.data(data: null);
    } else {
      emailSigninModel = AsyncValue.error(error: response.error!);
    }

    emit(AuthEmailSigninDataChangedState());
  }

  AsyncValue<void, AppFailure> googleSigninModel = AsyncValue.initial();
  void signinWithGoogle(BuildContext context) async {
    if (googleSigninModel.isLoading) {
      return;
    }

    googleSigninModel = AsyncValue.loading();
    emit(AuthGoogleSigninDataChangedState());

    final response = await _authRepo.signinWithGoogle(
      Theme.of(context).platform,
    );

    if (response.isData) {
      googleSigninModel = AsyncValue.data(data: null);
    } else {
      googleSigninModel = AsyncValue.error(error: response.error!);
    }
    emit(AuthGoogleSigninDataChangedState());
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

  void launchPrivacyPolicyWebpage() {
    FlutterWebBrowser.openWebPage(
      url: AppConstants.appPrivacyPolicyWebsiteUrl,
      customTabsOptions: const CustomTabsOptions(
        showTitle: true,
        urlBarHidingEnabled: true,
        instantAppsEnabled: true,
      ),
      safariVCOptions: const SafariViewControllerOptions(
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        // barCollapsingEnabled: true,
        // modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }

  void launchTermsOfUseWebpage() {
    FlutterWebBrowser.openWebPage(
      url: AppConstants.appTermsOfUseWebsiteUrl,
      customTabsOptions: const CustomTabsOptions(
        showTitle: true,
        urlBarHidingEnabled: true,
        instantAppsEnabled: true,
      ),
      safariVCOptions: const SafariViewControllerOptions(
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        // barCollapsingEnabled: true,
        // modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }

  // ----------------------- Forget Password Screen -----------------------
  final forgotPasswordScreenPageController = PageController(initialPage: 0);
  final forgotPasswordEmailFormKey = GlobalKey<FormState>();
  ForgotPasswordViewMode forgotPasswordViewMode =
      ForgotPasswordViewMode.enterEmail;

  void changeForgotPasswordPage(ForgotPasswordViewMode viewMode) {
    forgotPasswordViewMode = viewMode;
    emit(AuthPasswordResetViewModeChangedState());

    forgotPasswordScreenPageController.animateToPage(
      viewMode.pageIndex,
      duration: 300.ms,
      curve: Curves.fastOutSlowIn,
    );
  }

  AsyncValue<void, AppFailure> passwordResetRequestModel = AsyncValue.initial();
  void requestPasswordResetEmail(BuildContext context) async {
    if (passwordResetRequestModel.isLoading) {
      return;
    }

    if (validateEmail(context) != null) {
      forgotPasswordEmailFormKey.currentState?.validate();
      return;
    }

    passwordResetRequestModel = AsyncValue.loading();
    emit(AuthPasswordResetEmailRequestDataChangedState());

    final response = await _authRepo.requestPasswordReset(
      emailFieldController.text.trim(),
    );

    if (response.isData) {
      passwordResetRequestModel = AsyncValue.data(data: null);
    } else {
      passwordResetRequestModel = AsyncValue.error(error: response.error!);
    }
    emit(AuthPasswordResetEmailRequestDataChangedState());
  }

  @override
  Future<void> close() {
    nameFieldController.dispose();
    emailFieldController.dispose();
    signupPasswordFieldController.dispose();
    signupConfirmPasswordFieldController.dispose();
    signinPasswordFieldController.dispose();

    forgotPasswordScreenPageController.dispose();

    return super.close();
  }
}
