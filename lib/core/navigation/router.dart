import 'package:e_commerce/blogs/temp_blogs.dart';
import 'package:e_commerce/core/components/bottom_navbar.dart';
import 'package:e_commerce/home/temp_home.dart';
import 'package:e_commerce/profile/temp_profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home(name: 'home', path: '/'),
  profile(name: 'profile', path: '/profile'),
  blogs(name: 'blogs', path: '/blogs');

  const AppRoute({required this.name, required this.path});
  final String name;
  final String path;
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoute.home.path,
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
              path: AppRoute.home.path,
              name: AppRoute.home.name,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoute.profile.path,
              name: AppRoute.profile.name,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: AppRoute.blogs.name,
      path: AppRoute.blogs.path,
      builder: (context, state) => const BlogsScreen(),
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