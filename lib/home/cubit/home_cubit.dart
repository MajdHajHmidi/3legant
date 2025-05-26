import 'package:flutter_async_value/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/data/auth_repo.dart';
import '../../core/util/app_failure.dart';
import '../../core/util/dependency_injection.dart';
import '../data/home_repo.dart';
import '../models/home_data_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit({required HomeRepo homeRepo})
    : _homeRepo = homeRepo,
      super(HomeInitial()) {
    final user = serviceLocator<AuthRepo>().getCurrentUser();

    if (user != null) {
      getHomeData(user.id);
    }
  }

  AsyncValue<HomeDataModel, AppFailure> homeDataModel = AsyncValue.loading();
  Future<void> getHomeData(String userId) async {
    homeDataModel = AsyncValue.loading();
    emit(HomeDataChangedState());

    final result = await _homeRepo.getHomeData(userId: userId);

    if (result.isData) {
      homeDataModel = AsyncValue.data(data: result.data!);
      emit(HomeDataChangedState());
    } else {
      homeDataModel = AsyncValue.error(error: result.error!);
      emit(HomeDataChangedState());
    }
  }

  void toggleProductFavorite(int index) {
    if (!homeDataModel.isData) return;

    final products = homeDataModel.data!.newProducts.products;
    products[index] = products[index].copyWith(
      favorite: !products[index].favorite,
    );

    homeDataModel = AsyncValue.data(
      data: HomeDataModel(
        metadata: homeDataModel.data!.metadata,
        popularCategories: homeDataModel.data!.popularCategories,
        newProducts: NewProducts(products: products),
        popularBlogs: homeDataModel.data!.popularBlogs,
      ),
    );

    emit(HomeFavoriteProductToggleState());
  }
}
