part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthViewModeChangedState extends AuthState {}

final class AuthSignupHidePasswordToggledState extends AuthState {}

final class AuthSigninHidePasswordToggledState extends AuthState {}

final class AuthPrivacyPolicyToggledState extends AuthState {}

final class AuthEmailSigninLoadingState extends AuthState {}

final class AuthEmailSigninSuccessState extends AuthState {}

final class AuthEmailSigninErrorState extends AuthState {
  final AppFailure failure;
  AuthEmailSigninErrorState({required this.failure});
}

final class AuthGoogleSigninLoadingState extends AuthState {}

final class AuthGoogleSigninSuccessState extends AuthState {}

final class AuthGoogleSigninErrorState extends AuthState {
  final AppFailure failure;
  AuthGoogleSigninErrorState({required this.failure});
}

final class AuthGoogleSignupLoadingState extends AuthState {}

final class AuthGoogleSignupSuccessState extends AuthState {}

final class AuthGoogleSignupErrorState extends AuthState {
  final AppFailure failure;
  AuthGoogleSignupErrorState({required this.failure});
}

final class AuthEmailSignupLoadingState extends AuthState {}

final class AuthEmailSignupSuccessState extends AuthState {}

final class AuthEmailSignupErrorState extends AuthState {
  final AppFailure failure;
  AuthEmailSignupErrorState({required this.failure});
}

final class AuthPasswordResetEmailRequestLoadingState extends AuthState {}

final class AuthPasswordResetEmailRequestSuccessState extends AuthState {}

final class AuthPasswordResetEmailRequestFailureState extends AuthState {
  final AppFailure failure;
  AuthPasswordResetEmailRequestFailureState({required this.failure});
}

final class AuthPasswordResetViewModeChangedState extends AuthState {}
