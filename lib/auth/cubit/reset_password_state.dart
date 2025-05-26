part of 'reset_password_cubit.dart';

sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordRequestDataChangedState extends ResetPasswordState {}

final class ResetPasswordHidePasswordToggledState extends ResetPasswordState {}
