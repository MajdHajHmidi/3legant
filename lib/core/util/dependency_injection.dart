import '../../product_details/data/product_details_repo.dart';

import '../../blog_details/data/blog_details_repo.dart';
import '../../blogs/data/blogs_repo.dart';
import '../../cart/data/cart_repo.dart';
import '../cubit/app_cubit.dart';
import '../../shop/data/shop_repo.dart';
import '../../shop/presentation/cubit/shop_cubit.dart';

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
  serviceLocator.registerLazySingleton<BlogDetailsRepo>(
    () => SupabaseBlogDetailsRepo(),
  );
  serviceLocator.registerLazySingleton<ProductDetailsRepo>(
    () => SupabaseProductDetailsRepo(),
  );

  // Register app router
  serviceLocator.registerSingleton<GoRouter>(getAppRouter());

  // Register app cubits
  serviceLocator.registerLazySingleton<ShopCubit>(
    () => ShopCubit(shopRepo: serviceLocator<ShopRepo>()),
    dispose: (cubit) => cubit.close(),
  );
  serviceLocator.registerLazySingleton<AppCubit>(
    () => AppCubit(),
    dispose: (cubit) => cubit.close(),
  );
}
