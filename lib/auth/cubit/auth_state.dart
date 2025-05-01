part of 'auth_cubit.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthViewModeChangedState extends AuthState {}

final class AuthSignupHidePasswordToggledState extends AuthState {}

final class AuthSigninHidePasswordToggledState extends AuthState {}

final class AuthPrivacyPolicyToggledState extends AuthState {}