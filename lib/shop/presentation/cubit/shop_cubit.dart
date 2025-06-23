import '../../../auth/data/auth_repo.dart';
import '../../../core/util/app_failure.dart';
import '../../../core/util/dependency_injection.dart';
import '../../data/shop_repo.dart';
import '../../models/filtered_products_model.dart';
import '../../models/product_filters.dart';
import '../../models/shop_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shop_state.dart';

enum ProductsViewLayout { list, grid }

class ShopCubit extends Cubit<ShopState> {
  final ShopRepo _shopRepo;
  ShopCubit({required ShopRepo shopRepo})
    : _shopRepo = shopRepo,
      super(ShopInitial()) {
    final user = serviceLocator<AuthRepo>().getCurrentUser();

    if (user != null) {
      getShopScreenData();
    }
  }

  final queryTextController = TextEditingController();

  bool isProductsFiltersExpanded = false;
  void toggleProductsFiltersExpansion() {
    isProductsFiltersExpanded = !isProductsFiltersExpanded;
    emit(ShopProductsFilterExpansionToggledState());
  }

  ProductsViewLayout productsViewLayout = ProductsViewLayout.grid;
  void changeProductsViewLayout(ProductsViewLayout productsViewLayout) {
    if (this.productsViewLayout == productsViewLayout) return;
    this.productsViewLayout = productsViewLayout;
    emit(ShopProductsViewLayoutChangedState());
  }

  AsyncValue<ShopDataModel, AppFailure> shopDataModel = AsyncValue.initial();
  Future<void> getShopScreenData() async {
    shopDataModel = AsyncValue.loading();
    emit(ShopScreenDataChangedState());

    final result = await _shopRepo.getShopDataModel();

    if (result.isData) {
      shopDataModel = AsyncValue.data(data: result.data!);
      emit(ShopScreenDataChangedState());
    } else {
      shopDataModel = AsyncValue.error(error: result.error!);
      emit(ShopScreenDataChangedState());
    }
  }

  ProductFilters filters = ProductFilters.empty();
  void applyFilters(ProductFilters filters) {
    // If same filters, skip
    if (this.filters == filters) return;
    // Set new filters
    this.filters = filters;

    emit(ShopFilteredProductsFiltersChangedState());

    getFilteredProducts();
  }

  AsyncValue<FilteredProductsModel, AppFailure> filteredProducts =
      AsyncValue.initial();
  Future<void> getFilteredProducts({bool isPagination = false}) async {
    final user = serviceLocator<AuthRepo>().getCurrentUser();
    if (user == null) return;

    if (isPagination) {
      _getPaginatedData(userId: user.id);
      return;
    }

    _getNewData(userId: user.id);
  }

  Future<void> _getNewData({required String userId}) async {
    if (filteredProducts.isLoading) return;

    filteredProducts = AsyncValue.loading();
    emit(ShopFilteredProductsDataChangedState());

    final result = await _shopRepo.getFilteredProducts(
      userId: userId,
      filters: filters,
    );

    if (result.isData) {
      filteredProducts = AsyncValue.data(data: result.data!);
      _incrementPage();
      emit(ShopFilteredProductsDataChangedState());
    } else {
      filteredProducts = AsyncValue.error(error: result.error!);
      emit(ShopFilteredProductsDataChangedState());
    }
  }

  bool paginationLoading = false;
  Future<void> _getPaginatedData({required String userId}) async {
    if (paginationLoading) {
      return;
    }

    paginationLoading = true;
    emit(ShopFilteredProductsPaginationLoadingState());

    final result = await _shopRepo.getFilteredProducts(
      userId: userId,
      filters: filters,
    );

    paginationLoading = false;

    // Cancel operation if new filters applied before new page recieved
    if (filteredProducts.data == null) {
      return;
    }

    if (result.isData) {
      final newModel = _mergeProductPages(filteredProducts.data!, result.data!);
      filteredProducts = AsyncValue.data(data: newModel);
      _incrementPage();
      emit(ShopFilteredProductsDataChangedState());
    } else {
      emit(ShopFilteredProductsPaginationFailureState(failure: result.error!));
    }
  }

  FilteredProductsModel _mergeProductPages(
    FilteredProductsModel first,
    FilteredProductsModel second,
  ) {
    // TODO: Add "Race conditions" check
    // Check if pages are consecutive
    // if (first.paginationInfo.currentPage !=
    //     second.paginationInfo.currentPage - 1) {
    //   // Pages are not consecutive, skip merge
    //   return first;
    // }

    return FilteredProductsModel(
      products: [...first.products, ...second.products],
      paginationInfo: second.paginationInfo,
    );
  }

  void _incrementPage() {
    filters = filters.copyWith(page: filters.page + 1);
    emit(ShopFilteredProductsFiltersChangedState());
  }
}
