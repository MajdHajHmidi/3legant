import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../navigation/router.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  /// Auto focus to the search text field on screen launch
  bool shopScreenSeachAutoFocus = false;
  void launchShopScreen({
    required BuildContext context,
    bool autoFocus = false,
  }) {
    shopScreenSeachAutoFocus = autoFocus;
    emit(ShopScreenLaunchParamsChanged());

    context.goNamed(AppRoutes.shop.name);
  }

  void resetShopScreenLaunchParams() {
    shopScreenSeachAutoFocus = false;
    emit(ShopScreenLaunchParamsChanged());
  }
}
