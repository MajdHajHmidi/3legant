import '../constants/app_assets.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../util/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool showBackButton;
  final Widget? leadingIcon;
  final void Function()? leadingIconAction;
  CustomAppBar({
    required this.text,
    this.leadingIcon,
    this.leadingIconAction,
    this.showBackButton = true,
    super.key,
  }) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: AppBar(
        title: Text(
          text,
          style: AppTextStyles.body1Semi.copyWith(color: AppColors.neutral_06),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading:
            showBackButton
                ? InkWell(
                  borderRadius: BorderRadius.circular(360),
                  onTap: leadingIconAction ?? () => context.pop(),
                  child: Container(
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      getValueWithDirection(
                        context,
                        AppIcons.backLtr,
                        AppIcons.backRtl,
                      ),
                      width: 28,
                      theme: SvgTheme(currentColor: AppColors.neutral_06),
                    ),
                  ),
                )
                : null,
      ),
    );
  }
}
