import 'package:e_commerce/core/util/app_failure.dart';
import 'package:e_commerce/core/util/supabase_error_handling.dart';
import 'package:e_commerce/product_details/models/product_details_model.dart';
import 'package:e_commerce/product_details/models/product_reviews_model.dart';
import 'package:flutter_async_value/flutter_async_value.dart';

abstract class ProductDetailsRepo {
  Future<AsyncResult<ProductDetailsModel, AppFailure>> getProductDetails({
    required String userId,
    required String productId,
  });

  Future<AsyncResult<ProductReviewsModel, AppFailure>> getProductReviews({
    required String productId,
    required int page,
  });

  Future<AsyncResult<void, AppFailure>> submitProductReview({
    required String userId,
    required String productId,
    required double rating,
    String? comment,
  });
}

class SupabaseProductDetailsRepo extends ProductDetailsRepo {
  @override
  Future<AsyncResult<ProductDetailsModel, AppFailure>> getProductDetails({
    required String userId,
    required String productId,
  }) async {
    return await supabaseRpc(
      'get_product_details',
      params: {'user_id': userId, 'product_id': productId},
      fromJson: ProductDetailsModel.fromJson,
      get: true,
    );
  }

  @override
  Future<AsyncResult<ProductReviewsModel, AppFailure>> getProductReviews({
    required String productId,
    required int page,
  }) async {
    return await supabaseRpc(
      'get_product_ratings',
      params: {'product_id': productId, 'page': page},
      fromJson: ProductReviewsModel.fromJson,
      get: true,
    );
  }

  @override
  Future<AsyncResult<void, AppFailure>> submitProductReview({
    required String userId,
    required String productId,
    required double rating,
    String? comment,
  }) async {
    return await supabaseRpc(
      'insert_rating',
      params: {
        '_user_id': userId,
        '_product_id': productId,
        '_rating': rating,
        '_comment': comment,
      },
      customErrors: {'P1001': RpcFailureCodes.multipleProductReviews.name},
    );
  }
}
