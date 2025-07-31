import 'package:e_commerce/auth/data/auth_repo.dart';
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSignoutCubit extends Cubit<AsyncValue<void, AppFailure>> {
  final AuthRepo _authRepo;
  ProfileSignoutCubit({required AuthRepo authRepo})
    : _authRepo = authRepo,
      super(AsyncValue.initial());

  Future<void> signOut() async {
    if (state.isLoading) return;

    emit(AsyncValue.loading());

    final result = await _authRepo.signOut();

    if (result.isData) {
      emit(AsyncValue.data(data: null));
    } else {
      emit(AsyncValue.error(error: result.error!));
    }
  }
}
