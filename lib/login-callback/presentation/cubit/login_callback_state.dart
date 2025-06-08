part of 'login_callback_cubit.dart';

sealed class LoginCallbackState {}

final class LoginCallbackInitial extends LoginCallbackState {}

final class LoginCallbackSuccessState extends LoginCallbackState {}

final class LoginCallbackFailureState extends LoginCallbackState {}
