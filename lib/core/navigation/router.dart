import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/data/auth_repo.dart';
import 'package:e_commerce/auth/presentation/screens/auth_forgot_password.dart';
import 'package:e_commerce/auth/presentation/screens/auth_screen.dart';
import 'package:e_commerce/blogs/temp_blogs.dart';
import 'package:e_commerce/core/widgets/bottom_navbar.dart';
import 'package:e_commerce/home/temp_home.dart';
import 'package:e_commerce/profile/temp_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum AppRoutes {
  home(name: 'home', path: '/'),
  profile(name: 'profile', path: '/profile'),
  blogs(name: 'blogs', path: '/blogs'),
  auth(name: 'auth', path: '/auth'),
  forgotPassword(name: 'forgotPassword', path: '/auth/forgotPassword');

  const AppRoutes({required this.name, required this.path});
  final String name;
  final String path;
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home.path,
  redirect: (context, state) {
    final session = Supabase.instance.client.auth.currentSession;
    final isLoggedIn = session != null;

    // List of auth-related screens
    final isAuthRoute = [
      AppRoutes.auth.path,
      AppRoutes.forgotPassword.path,
      '/login-callback',
    ].any((path) => state.uri.toString().contains(path));

    // While not authenticated:
    // redirect to auth screen unless currently in an auth-related screen
    if (!isLoggedIn && !isAuthRoute) {
      return AppRoutes.auth.path;
    }

    // If tried to access auth screen while already authenticated, redirect to home
    if (isLoggedIn && state.uri.path == AppRoutes.auth.path) {
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
              builder: (context, state) => const HomeScreen(),
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
      ],
    ),
    GoRoute(
      name: AppRoutes.blogs.name,
      path: AppRoutes.blogs.path,
      builder: (context, state) => const BlogsScreen(),
    ),
    GoRoute(
      name: AppRoutes.auth.name,
      path: AppRoutes.auth.path,
      builder:
          (context, state) => BlocProvider(
            create: (context) => AuthCubit(authRepo: SupabaseAuthRepo()),
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
  ],
);




/*
* The following is an example of using parameters in GoRouter:

enum AppRoute {
  userDetails(name: 'userDetails', path: '/user/:id');

  const AppRoute({required this.name, required this.path});
  final String name;
  final String path;
}

GoRoute(
  name: AppRoute.userDetails.name,
  path: AppRoute.userDetails.path,
  builder: (context, state) {
    final userId = state.params['id']!;
    return UserDetailsPage(userId: userId);
  },
);


* And navigate to it like so:
context.goNamed(AppRoute.userDetails.name, params: {'id': '123'});
*/