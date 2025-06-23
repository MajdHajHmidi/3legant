import 'dart:async';

import 'package:e_commerce/auth/data/auth_repo.dart';
import 'package:e_commerce/core/constants/app_constants.dart';
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:e_commerce/core/util/dependency_injection.dart';
import 'package:e_commerce/product_details/data/product_details_repo.dart';
import 'package:e_commerce/product_details/models/product_details_model.dart';
import 'package:e_commerce/product_details/models/product_reviews_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepo _productDetailsRepo;
  final String productId;
  ProductDetailsCubit({
    required ProductDetailsRepo productDetailsRepo,
    required this.productId,
  }) : _productDetailsRepo = productDetailsRepo,
       super(ProductDetailsInitial()) {
    final user = serviceLocator<AuthRepo>().getCurrentUser();

    if (user != null) {
      getProductDetails(userId: user.id, productId: productId);
      getProductReviews(
        productId: productId,
        pageIndex: AppConstants.appStartingPaginationIndex,
      );
    }
  }

  // ---------------- Product Details Data State Management ----------------
  AsyncValue<ProductDetailsModel, AppFailure> productDetailsModel =
      AsyncValue.initial();
  Future<void> getProductDetails({
    required String userId,
    required String productId,
  }) async {
    if (productDetailsModel.isLoading) return;
    productDetailsModel = AsyncValue.loading();
    emit(ProductDetailsDataChangedState());

    final result = await _productDetailsRepo.getProductDetails(
      userId: userId,
      productId: productId,
    );

    if (result.isData) {
      productDetailsModel = AsyncValue.data(data: result.data!);
      emit(ProductDetailsDataChangedState());
    } else {
      productDetailsModel = AsyncValue.error(error: result.error!);
      emit(ProductDetailsDataChangedState());
    }
  }

  // Runs when a user submits a review/rating to change the rating count on screen
  void updateReviewsCountWhenSubmitted({
    required int ratingsCount,
    required int reviewsCount,
  }) {
    final newData = productDetailsModel.data!.copyWithRatings(
      ratingsCount: ratingsCount,
      reviewsCount: reviewsCount,
    );

    productDetailsModel = AsyncValue.data(data: newData);

    print(productDetailsModel.data!.ratingsCount ?? 0);
    emit(ProductDetailsDataChangedState());
  }

  // ---------------- Product Reviews Data State Management ----------------
  PaginatedAsyncValue<ProductReviewsModel, AppFailure> productReviewsModel =
      PaginatedAsyncValue.initial();
  Future<void> getProductReviews({
    required String productId,
    required int pageIndex,
  }) async {
    if (productReviewsModel.isLoading) {
      return;
    }

    // Reset states
    if (pageIndex == AppConstants.appStartingPaginationIndex) {
      productReviewsModel = PaginatedAsyncValue.initial();
    }

    productReviewsModel = PaginatedAsyncValue.loading(
      previous: productReviewsModel,
    );
    emit(ProductReviewsDataChangedState());

    final result = await _productDetailsRepo.getProductReviews(
      productId: productId,
      page: pageIndex,
    );

    if (result.isData) {
      productReviewsModel = PaginatedAsyncValue.data(
        data: result.data!,
        previous: productReviewsModel,
        combine:
            (first, second) => ProductReviewsModel(
              reviews: [...first.reviews, ...second.reviews],
              paginationInfo: second.paginationInfo,
            ),
      );
    } else {
      productReviewsModel = PaginatedAsyncValue.error(
        error: result.error!,
        previous: productReviewsModel,
      );
    }
    emit(ProductReviewsDataChangedState());
  }

  // -------------------- Product Color State Management --------------------
  int selectedColorIndex = 0;
  void changeSelectedColor(int index) {
    selectedColorIndex = index;
    emit(ProductDetailsColorChangedState());
  }

  // -------------- Product Reviews Expansion State Management --------------
  bool isProductReviewsExpanded = false;
  void toggleProductReviewsExpansion() {
    isProductReviewsExpanded = !isProductReviewsExpanded;
    emit(ProductDetailsReviewsExpandedState());
  }

  // -------------- Product Info Expansion State Management --------------
  bool isProductInfoExpanded = false;
  void toggleProductInfoExpansion() {
    isProductInfoExpanded = !isProductInfoExpanded;
    emit(ProductDetailsInfoExpandedState());
  }

  // -------------- Product Cart Quantity State Management --------------
  int quantityInCart = 1;
  void incrementQuantityInCart() {
    ++quantityInCart;

    emit(ProductDetailsCartQuantityChangedState());
  }

  void decrementQuantityInCart() {
    if (quantityInCart == 1) return;

    --quantityInCart;

    emit(ProductDetailsCartQuantityChangedState());
  }

  // -------------- Product User Rating State Management --------------
  double rating = 0.0;
  void changeRating(double rating) {
    this.rating = rating;

    emit(ProductDetailsRatingChangedState());
  }

  final userReviewTextController = TextEditingController();
  AsyncValue<void, AppFailure> userReviewSubmitModel = AsyncValue.initial();
  Future<void> submitReview() async {
    if (userReviewSubmitModel.isLoading) return;
    userReviewSubmitModel = AsyncValue.loading();
    emit(ProductDetailsReviewDataChangedState());

    final comment = userReviewTextController.text;
    final user = serviceLocator<AuthRepo>().getCurrentUser();

    if (user == null) {
      userReviewSubmitModel = AsyncValue.error(
        error: NetworkFailure(code: RpcFailureCodes.other.name),
      );
      emit(ProductDetailsReviewDataChangedState());

      return;
    }

    final result = await _productDetailsRepo.submitProductReview(
      userId: user.id,
      productId: productId,
      rating: rating,
      comment: comment.isEmpty ? null : comment,
    );

    if (result.isData) {
      userReviewSubmitModel = AsyncValue.data(data: null);
      emit(ProductDetailsReviewDataChangedState());

      // Post-success operations
      userReviewTextController.clear();
      updateReviewsCountWhenSubmitted(
        ratingsCount: (productDetailsModel.data!.ratingsCount ?? 0) + 1,
        reviewsCount:
            (productDetailsModel.data!.reviewsCount ?? 0) +
            (comment.isEmpty ? 0 : 1),
      );
      getProductReviews(
        productId: productId,
        pageIndex: AppConstants.appStartingPaginationIndex,
      );
    } else {
      userReviewSubmitModel = AsyncValue.error(error: result.error!);
      emit(ProductDetailsReviewDataChangedState());
    }
  }

  // ------------ Discount Expiration Countdown State Management ------------
  Timer? _discountExpirationtimer;
  StreamController<Duration>? _discountCountdownController;
  Stream<Duration>? get countdownStream => _discountCountdownController?.stream;

  void startDiscountExpirationTimer(DateTime endDate) {
    _discountCountdownController = StreamController<Duration>.broadcast();
    _emitRemaining(endDate); // Emit first value

    _discountExpirationtimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (!isClosed) _emitRemaining(endDate);
    });
  }

  void _emitRemaining(DateTime endDate) {
    final now = DateTime.now().toUtc();
    final diff = endDate.difference(now);
    final remaining = diff.isNegative ? Duration.zero : diff;
    _discountCountdownController?.add(remaining);

    if (remaining == Duration.zero) {
      _discountExpirationtimer?.cancel();
    }
  }

  @override
  Future<void> close() {
    _discountExpirationtimer?.cancel();
    _discountCountdownController?.close();
    userReviewTextController.dispose();

    return super.close();
  }
}
