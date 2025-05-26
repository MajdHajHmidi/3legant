part of 'favorite_cubit.dart';

sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteChangedState extends FavoriteState {}

final class FavoriteFailureState extends FavoriteState {}

final class FavoriteSuccessState extends FavoriteState {}
