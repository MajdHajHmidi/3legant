// ignore_for_file: deprecated_member_use

import 'package:e_commerce/core/constants/app_assets.dart';
import 'package:e_commerce/core/cubit/app_cubit.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/util/dependency_injection.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavbar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppBottomNavbar({super.key, required this.navigationShell});

  void _onTap(int index) {
    serviceLocator<AppCubit>().resetShopScreenLaunchParams();
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Only pop if in `home` tab
      canPop: navigationShell.currentIndex == 0,
      onPopInvoked: (didPop) {
        navigationShell.goBranch(0);
      },
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _onTap,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.home,
                color: AppColors.neutral_04,
              ),
              activeIcon: SvgPicture.asset(
                AppIcons.home,
                color: AppColors.neutral_06,
              ),
              label: localization(context).navHome,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.shoppingCart,
                color: AppColors.neutral_04,
              ),
              activeIcon: SvgPicture.asset(
                AppIcons.shoppingCart,
                color: AppColors.neutral_06,
              ),
              label: localization(context).navShop,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.profile,
                color: AppColors.neutral_04,
              ),
              activeIcon: SvgPicture.asset(
                AppIcons.profile,
                color: AppColors.neutral_06,
              ),
              label: localization(context).navProfile,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.cart,
                color: AppColors.neutral_04,
              ),
              activeIcon: SvgPicture.asset(
                AppIcons.cart,
                color: AppColors.neutral_06,
              ),
              label: localization(context).navCart,
            ),
          ],
        ),
      ),
    );
  }
}
