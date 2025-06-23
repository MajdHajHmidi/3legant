part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

/// Screen Data
final class ProductDetailsDataChangedState extends ProductDetailsState {}

/// Reviews Data
final class ProductReviewsDataChangedState extends ProductDetailsState {}

/// Product Color
final class ProductDetailsColorChangedState extends ProductDetailsState {}

/// Product Info Expansion
final class ProductDetailsInfoExpandedState extends ProductDetailsState {}

/// Product Reviews Expansion
final class ProductDetailsReviewsExpandedState extends ProductDetailsState {}

/// Product User Review Request Data
final class ProductDetailsReviewDataChangedState extends ProductDetailsState {}

/// Product User Rating
final class ProductDetailsRatingChangedState extends ProductDetailsState {}

/// Product Quantity In Cart
final class ProductDetailsCartQuantityChangedState
    extends ProductDetailsState {}
