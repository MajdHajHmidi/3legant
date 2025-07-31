part of 'blogs_cubit.dart';

sealed class BlogsState {}

final class BlogsInitial extends BlogsState {}

final class BlogsDataChangedState extends BlogsState {}

final class BlogsChangedCategoryLoadingState extends BlogsState {}

final class BlogsChangedCategoryErrorState extends BlogsState {
  final AppFailure failure;

  BlogsChangedCategoryErrorState({required this.failure});
}

final class BlogsCategoryChangedState extends BlogsState {}
