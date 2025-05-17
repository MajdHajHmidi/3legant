part of 'reset_password_cubit.dart';

sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordRequestLoadingState extends ResetPasswordState {}

final class ResetPasswordRequestSuccessState extends ResetPasswordState {}

final class ResetPasswordRequestFailureState extends ResetPasswordState {
  final AppFailure failure;
  ResetPasswordRequestFailureState({required this.failure});
}

final class ResetPasswordHidePasswordToggledState extends ResetPasswordState {}
