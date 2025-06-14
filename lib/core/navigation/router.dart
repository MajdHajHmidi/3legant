import '../../blog_details/data/blog_details_repo.dart';
import '../../blog_details/presentation/cubit/blog_details_cubit.dart';
import '../../blog_details/presentation/screens/blog_details_screen.dart';
import '../../blogs/data/blogs_repo.dart';
import '../../blogs/presentation/cubit/blogs_cubit.dart';
import '../../blogs/presentation/screens/blogs_screen.dart';
import '../../cart/data/cart_repo.dart';
import '../../cart/presentation/cubit/cart_cubit.dart';
import '../../cart/presentation/screens/cart_screen.dart';
import '../../shop/presentation/screens/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth/presentation/cubit/auth_cubit.dart';
import '../../auth/presentation/cubit/reset_password_cubit.dart';
import '../../auth/data/auth_repo.dart';
import '../../auth/presentation/screens/auth_forgot_password.dart';
import '../../auth/presentation/screens/auth_screen.dart';
import '../../auth/presentation/screens/reset_password_screen.dart';
import '../../home/presentation/cubit/home_cubit.dart';
import '../../home/data/home_repo.dart';
import '../../home/presentation/screens/home_screen.dart';
import '../../login-callback/presentation/cubit/login_callback_cubit.dart';
import '../../login-callback/presentation/screens/login_callback_screen.dart';
import '../../profile/temp_profile.dart';
import '../constants/app_constants.dart';
import '../util/dependency_injection.dart';
import '../widgets/bottom_navbar.dart';

enum AppRoutes {
  home(name: 'home', path: '/'),
  profile(name: 'profile', path: '/profile'),
  blogs(name: 'blogs', path: '/blogs'),
  blogDetails(name: 'blogDetails', path: '/blogDetails/:blog_id'),
  auth(name: 'auth', path: '/auth'),
  forgotPassword(name: 'forgotPassword', path: '/auth/forgotPassword'),
  resetPassword(name: 'resetPassword', path: '/resetPassword'),
  loginCallback(name: 'loginCallback', path: '/loginCallback'),
  shop(name: 'shop', path: '/shop'),
  cart(name: 'cart', path: '/cart');

  const AppRoutes({required this.name, required this.path});
  final String name;
  final String path;
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter getAppRouter() => GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home.path,
  redirect: (context, state) {
    final session = Supabase.instance.client.auth.currentSession;
    final isLoggedIn = session != null;

    // Handle deeplink redirection
    if (state.uri.host == AppConstants.emailPasswordResetSupabaseRedirectHost) {
      return AppRoutes.resetPassword.path;
    } else if (state.uri.host ==
        AppConstants.emailVerificationSupabaseRedirectHost) {
      return AppRoutes.loginCallback.path;
    }

    // List of auth-related screens
    final isAuthRoute = [
      AppRoutes.auth.path,
      AppRoutes.forgotPassword.path,
      AppRoutes.resetPassword.path,
      AppRoutes.loginCallback.path,
    ].any((path) => state.uri.path == path);

    // While not authenticated:
    // redirect to auth screen unless currently in an auth-related screen
    if (!isLoggedIn && !isAuthRoute) {
      return AppRoutes.auth.path;
    }

    // If tried to access auth screen while already authenticated, redirect to home
    if (isLoggedIn && isAuthRoute) {
      return AppRoutes.home.path;
    }

    return null;
  },
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppBottomNavbar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home.path,
              name: AppRoutes.home.name,
              builder:
                  (context, state) => BlocProvider(
                    create:
                        (_) => HomeCubit(homeRepo: serviceLocator<HomeRepo>()),
                    child: const HomeScreen(),
                  ),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.shop.path,
              name: AppRoutes.shop.name,
              builder: (context, state) => ShopScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile.path,
              name: AppRoutes.profile.name,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.cart.path,
              name: AppRoutes.cart.name,
              builder:
                  (context, state) => BlocProvider(
                    create:
                        (_) => CartCubit(cartRepo: serviceLocator<CartRepo>()),
                    child: const CartScreen(),
                  ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: AppRoutes.blogs.name,
      path: AppRoutes.blogs.path,
      builder:
          (context, state) => BlocProvider(
            create: (_) => BlogsCubit(blogsRepo: serviceLocator<BlogsRepo>()),
            child: const BlogsScreen(),
          ),
    ),
    GoRoute(
      name: AppRoutes.blogDetails.name,
      path: AppRoutes.blogDetails.path,
      builder:
          (context, state) => BlocProvider(
            create:
                (_) => BlogDetailsCubit(
                  blogDetailsRepo: serviceLocator<BlogDetailsRepo>(),
                  blogId: state.pathParameters['blog_id'] as String,
                ),
            child: const BlogDetailsScreen(),
          ),
    ),
    GoRoute(
      name: AppRoutes.auth.name,
      path: AppRoutes.auth.path,
      builder:
          (context, state) => BlocProvider(
            create: (_) => AuthCubit(authRepo: serviceLocator<AuthRepo>()),
            child: const AuthScreen(),
          ),
    ),
    GoRoute(
      name: AppRoutes.forgotPassword.name,
      path: AppRoutes.forgotPassword.path,
      builder:
          (context, state) => BlocProvider.value(
            value: state.extra! as AuthCubit,
            child: const AuthForgotPassword(),
          ),
    ),
    GoRoute(
      name: AppRoutes.resetPassword.name,
      path: AppRoutes.resetPassword.path,
      builder: (context, state) {
        return BlocProvider(
          create:
              (_) => ResetPasswordCubit(authRepo: serviceLocator<AuthRepo>()),
          child: const ResetPasswordScreen(),
        );
      },
    ),
    GoRoute(
      name: AppRoutes.loginCallback.name,
      path: AppRoutes.loginCallback.path,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => LoginCallbackCubit()..initSupabaseAuthStateChanges(),
          child: const LoginCallbackScreen(),
        );
      },
    ),
  ],
);
