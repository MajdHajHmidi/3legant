part of 'shop_cubit.dart';

sealed class ShopState {}

final class ShopInitial extends ShopState {}

// Screen data changed (Header & filters)
final class ShopScreenDataChangedState extends ShopState {}

// Products data changed
final class ShopFilteredProductsDataChangedState extends ShopState {}

// Products pagination loading
final class ShopFilteredProductsPaginationLoadingState extends ShopState {}

// Products pagination failure
final class ShopFilteredProductsPaginationFailureState extends ShopState {
  final AppFailure failure;

  ShopFilteredProductsPaginationFailureState({required this.failure});
}

// New filters applied
final class ShopFilteredProductsFiltersChangedState extends ShopState {}

// Changed products view layout
final class ShopProductsViewLayoutChangedState extends ShopState {}

// Toggled products filter expansion
final class ShopProductsFilterExpansionToggledState extends ShopState {}
