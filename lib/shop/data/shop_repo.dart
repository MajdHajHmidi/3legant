import '../../core/util/app_failure.dart';
import '../../core/util/supabase_error_handling.dart';
import '../models/filtered_products_model.dart';
import '../models/product_filters.dart';
import '../models/shop_data_model.dart';
import 'package:flutter_async_value/flutter_async_value.dart';

abstract class ShopRepo {
  Future<AsyncResult<ShopDataModel, AppFailure>> getShopDataModel();

  Future<AsyncResult<FilteredProductsModel, AppFailure>> getFilteredProducts({
    required String userId,
    required ProductFilters filters,
  });
}

class SupabaseShopRepo extends ShopRepo {
  @override
  Future<AsyncResult<ShopDataModel, AppFailure>> getShopDataModel() async {
    return await supabaseRpc(
      'get_shop_page_data',
      fromJson: ShopDataModel.fromJson,
    );
  }

  @override
  Future<AsyncResult<FilteredProductsModel, AppFailure>> getFilteredProducts({
    required String userId,
    required ProductFilters filters,
  }) async {
    return await supabaseRpc(
      'get_filtered_products',
      params: {
        'user_id': userId,
        'category_id': filters.categoryId,
        'page': filters.page,
        if (filters.query.isNotEmpty) 'search_query': filters.query,
        if (filters.minPrice != null) 'min_price': filters.minPrice,
        if (filters.maxPrice != null) 'max_price': filters.maxPrice,
      },
      fromJson: FilteredProductsModel.fromJson,
      get: true,
    );
  }
}
