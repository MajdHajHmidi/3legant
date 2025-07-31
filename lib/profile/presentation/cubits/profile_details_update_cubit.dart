import 'package:e_commerce/core/util/app_failure.dart';
import 'package:e_commerce/profile/data/profile_repo.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDetailsUpdateCubit extends Cubit<AsyncValue<String, AppFailure>> {
  final ProfileRepo profileRepo;
  ProfileDetailsUpdateCubit({required this.profileRepo})
    : super(AsyncValue.initial());

  Future<void> updateAccountDetails({required String username}) async {
    if (state.isLoading) return;

    emit(AsyncValue.loading());

    final result = await profileRepo.changeUsername(username: username);

    if (result.isData) {
      emit(AsyncValue.data(data: username));
    } else {
      emit(AsyncValue.error(error: result.error!));
    }
  }
}
