import 'package:e_commerce/blogs/data/blogs_repo.dart';
import 'package:e_commerce/cart/data/cart_repo.dart';
import 'package:e_commerce/shop/data/shop_repo.dart';

import '../../favorite/data/favorite_repo.dart';

import '../../auth/data/auth_repo.dart';
import '../navigation/router.dart';
import '../../home/data/home_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final serviceLocator = GetIt.instance;

void setupDependencyInjection() {
  // Register app repositories
  serviceLocator.registerLazySingleton<AuthRepo>(() => SupabaseAuthRepo());
  serviceLocator.registerLazySingleton<HomeRepo>(() => SupabaseHomeRepo());
  serviceLocator.registerLazySingleton<FavoriteRepo>(
    () => SupabaseFavoriteRepo(),
  );
  serviceLocator.registerLazySingleton<CartRepo>(
    () => SupabaseSqliteCartRepo(),
  );
  serviceLocator.registerLazySingleton<ShopRepo>(() => SupabaseShopRepo());
  serviceLocator.registerLazySingleton<BlogsRepo>(() => SupabaseBlogsRepo());
  // Register app router
  serviceLocator.registerSingleton<GoRouter>(getAppRouter());
}
