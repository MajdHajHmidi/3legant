import 'package:e_commerce/auth/temp_auth.dart';
import 'package:e_commerce/blogs/temp_blogs.dart';
import 'package:e_commerce/core/widgets/bottom_navbar.dart';
import 'package:e_commerce/home/temp_home.dart';
import 'package:e_commerce/profile/temp_profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum AppRoutes {
  home(name: 'home', path: '/'),
  profile(name: 'profile', path: '/profile'),
  blogs(name: 'blogs', path: '/blogs'),
  login(name: 'login', path: '/login');

  const AppRoutes({required this.name, required this.path});
  final String name;
  final String path;
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home.path,
  redirect: (context, state) {
    final session = Supabase.instance.client.auth.currentSession;
    final isLoggedIn = session != null;

    final isLoggingIn = state.path == '/login';

    if (!isLoggedIn && !isLoggingIn) {
      return '/login';
    } else if (isLoggedIn && isLoggingIn) {
      return '/';
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
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.home.path,
              name: AppRoutes.home.name,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
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
      name: AppRoutes.login.name,
      path: AppRoutes.login.path,
      builder: (context, state) => const LoginScreen(),
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