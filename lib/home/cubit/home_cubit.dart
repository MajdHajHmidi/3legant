import 'package:e_commerce/auth/data/auth_repo.dart';
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:e_commerce/core/util/dependency_injection.dart';
import 'package:e_commerce/home/data/home_repo.dart';
import 'package:e_commerce/home/models/home_data_model.dart';
import 'package:flutter_async_value/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
}
