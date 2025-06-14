part of 'blog_details_cubit.dart';

sealed class BlogDetailsState {}

final class BlogDetailsInitial extends BlogDetailsState {}

final class BlogDetailsDataChangedState extends BlogDetailsState {}
