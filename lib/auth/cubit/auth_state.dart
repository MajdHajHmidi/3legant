part of 'auth_cubit.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthViewModeChangedState extends AuthState {}

final class AuthSignupHidePasswordToggledState extends AuthState {}

final class AuthSigninHidePasswordToggledState extends AuthState {}

final class AuthPrivacyPolicyToggledState extends AuthState {}

final class AuthEmailSigninLoadingState extends AuthState {}

final class AuthEmailSigninSuccessState extends AuthState {}

final class AuthEmailSigninErrorState extends AuthState {
  final int statusCode;
  AuthEmailSigninErrorState({required this.statusCode});
}

final class AuthGoogleSigninLoadingState extends AuthState {}

final class AuthGoogleSigninSuccessState extends AuthState {}

final class AuthGoogleSigninErrorState extends AuthState {
  final int statusCode;
  AuthGoogleSigninErrorState({required this.statusCode});
}

final class AuthGoogleSignupLoadingState extends AuthState {}

final class AuthGoogleSignupSuccessState extends AuthState {}

final class AuthGoogleSignupErrorState extends AuthState {
  final int statusCode;
  AuthGoogleSignupErrorState({required this.statusCode});
}

final class AuthEmailSignupLoadingState extends AuthState {}

final class AuthEmailSignupSuccessState extends AuthState {}

final class AuthEmailSignupErrorState extends AuthState {
  final int statusCode;
  AuthEmailSignupErrorState({required this.statusCode});
}
