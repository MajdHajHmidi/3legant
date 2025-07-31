import 'package:e_commerce/auth/data/auth_repo.dart';
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:e_commerce/core/util/dependency_injection.dart';
import 'package:e_commerce/profile/data/profile_repo.dart';
import 'package:e_commerce/profile/domain/profile_data_model.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreenDataCubit
    extends Cubit<AsyncValue<ProfileDataModel, AppFailure>> {
  final ProfileRepo _profileRepo;
  ProfileScreenDataCubit({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo,
      super(AsyncValue.initial()) {
    final user = serviceLocator<AuthRepo>().getCurrentUser();

    if (user != null) {
      getData(userId: user.id);
    }
  }

  Future<void> getData({required String userId}) async {
    if (state.isLoading) {
      return;
    }

    emit(AsyncValue.loading());

    final response = await _profileRepo.getHomeData(userId: userId);

    if (response.isData) {
      emit(AsyncValue.data(data: response.data!));
    } else {
      emit(AsyncValue.error(error: response.error!));
    }
  }

  void updateUsername(String username) {
    final newData = state.data!.copyWith(
      accountDetails: state.data!.accountDetails.copyWith(
        displayName: username,
      ),
    );
    emit(AsyncValue.data(data: newData));
  }
}
