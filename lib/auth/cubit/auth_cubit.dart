import 'dart:async';
import 'package:e_commerce/auth/data/auth_repo.dart';
import 'package:e_commerce/core/constants/app_constants.dart';
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:e_commerce/core/util/duration_extension.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
part 'auth_state.dart';

enum AuthViewMode { signup, signin }

enum ForgotPasswordViewMode {
  enterEmail(pageIndex: 0),
  checkInbox(pageIndex: 1);

  const ForgotPasswordViewMode({required this.pageIndex});
  final int pageIndex;
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit({required this.authRepo}) : super(AuthInitial());

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
    final response = await authRepo.signupWithEmailAndPassword(
      email: emailFieldController.text.trim(),
      password: signupPasswordFieldController.text.trim(),
      name: nameFieldController.text.trim(),
    );

    emailSignupLoading = false;
    if (response.isData) {
      emit(AuthEmailSignupSuccessState());
    } else {
      emit(AuthEmailSignupErrorState(failure: response.error!));
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

    final response = await authRepo.signupWithGoogle(
      Theme.of(context).platform,
    );

    googleSignupLoading = false;

    if (response.isData) {
      emit(AuthGoogleSignupSuccessState());
    } else {
      emit(AuthGoogleSignupErrorState(failure: response.error!));
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
    final response = await authRepo.signinWithEmailAndPassword(
      email: emailFieldController.text.trim(),
      password: signinPasswordFieldController.text.trim(),
    );

    emailSignInLoading = false;
    if (response.isData) {
      emit(AuthEmailSigninSuccessState());
    } else {
      emit(AuthEmailSigninErrorState(failure: response.error!));
    }
  }

  bool googleSignInLoading = false;
  void signinWithGoogle(BuildContext context) async {
    if (googleSignInLoading) {
      return;
    }

    googleSignInLoading = true;
    emit(AuthGoogleSigninLoadingState());

    final response = await authRepo.signinWithGoogle(
      Theme.of(context).platform,
    );

    googleSignInLoading = false;

    if (response.isData) {
      emit(AuthGoogleSigninSuccessState());
    } else {
      emit(AuthGoogleSigninErrorState(failure: response.error!));
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

  bool requestPasswordResetEmailLoading = false;
  void requestPasswordResetEmail(BuildContext context) async {
    if (requestPasswordResetEmailLoading) {
      return;
    }

    if (validateEmail(context) != null) {
      forgotPasswordEmailFormKey.currentState?.validate();
      return;
    }

    requestPasswordResetEmailLoading = true;
    emit(AuthPasswordResetEmailRequestLoadingState());

    final response = await authRepo.requestPasswordReset(
      emailFieldController.text.trim(),
    );

    requestPasswordResetEmailLoading = false;

    if (response.isData) {
      emit(AuthPasswordResetEmailRequestSuccessState());
    } else {
      emit(AuthPasswordResetEmailRequestFailureState(failure: response.error!));
    }
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
