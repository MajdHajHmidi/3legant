import 'package:e_commerce/auth/data/auth_repo.dart';
import 'package:e_commerce/core/navigation/router.dart';
import 'package:e_commerce/home/data/home_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final serviceLocator = GetIt.instance;

void setupDependencyInjection() {
  // Register app repositories
  serviceLocator.registerLazySingleton<AuthRepo>(() => SupabaseAuthRepo());
  serviceLocator.registerLazySingleton<HomeRepo>(() => SupabaseHomeRepo());

  // Register app router
  serviceLocator.registerSingleton<GoRouter>(getAppRouter());
}
