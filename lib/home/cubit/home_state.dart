part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeDataChangedState extends HomeState {}

final class HomeCarouselPageChangedState extends HomeState {}

final class HomeFavoriteProductToggleState extends HomeState {}
