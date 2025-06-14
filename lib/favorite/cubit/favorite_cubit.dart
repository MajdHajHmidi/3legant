import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/data/auth_repo.dart';
import '../../core/util/dependency_injection.dart';
import '../data/favorite_repo.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepo favoriteRepo;
  FavoriteCubit(this.isFavorite, {required this.favoriteRepo})
    : super(FavoriteInitial());

  late bool isFavorite;

  void toggle(String productId) async {
    // Change UI
    isFavorite = !isFavorite;
    emit(FavoriteChangedState());

    final user = serviceLocator<AuthRepo>().getCurrentUser();
    if (user == null) return;

    final response = await favoriteRepo.toggleFavorite(
      userId: user.id,
      productId: productId,
    );

    if (response.isData) {
      emit(FavoriteSuccessState());
    } else {
      isFavorite = !isFavorite;
      emit(FavoriteFailureState());
    }
  }
}
