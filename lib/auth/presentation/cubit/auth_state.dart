part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthViewModeChangedState extends AuthState {}

final class AuthSignupHidePasswordToggledState extends AuthState {}

final class AuthSigninHidePasswordToggledState extends AuthState {}

final class AuthPrivacyPolicyToggledState extends AuthState {}

final class AuthEmailSigninDataChangedState extends AuthState {}

final class AuthGoogleSigninDataChangedState extends AuthState {}

final class AuthGoogleSignupDataChangedState extends AuthState {}

final class AuthEmailSignupDataChangedState extends AuthState {}

final class AuthPasswordResetEmailRequestDataChangedState extends AuthState {}

final class AuthPasswordResetViewModeChangedState extends AuthState {}
