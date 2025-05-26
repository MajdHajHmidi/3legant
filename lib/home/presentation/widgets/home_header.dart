import '../../../auth/data/auth_repo.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/util/dependency_injection.dart';
import '../../../core/util/localization.dart';
import '../../../core/util/testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Row(
        children: [
          Builder(
            builder: (context) {
              final user = serviceLocator<AuthRepo>().getCurrentUser();

              return Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${localization(context).hello}\n',
                      style: AppTextStyles.caption1.copyWith(
                        color: AppColors.neutral_04,
                        height: 1,
                      ),
                    ),
                    TextSpan(
                      text: user?.name.split(' ').first ?? '',
                      style: AppTextStyles.headline6.copyWith(
                        color: AppColors.neutral_06,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Spacer(),
          InkWell(
            onTap: () => showNotImplementedDialog(context),
            borderRadius: BorderRadius.circular(360),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                color: AppColors.neutral_02.withAlpha(128),
              ),
              child: SvgPicture.asset(
                AppIcons.search,
                height: 24,
                width: 24,
                theme: SvgTheme(currentColor: AppColors.neutral_05),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
