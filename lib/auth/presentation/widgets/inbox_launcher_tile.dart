import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/util/localization.dart';

class InboxLauncherTile extends StatelessWidget {
  final bool bigScale;
  const InboxLauncherTile.big({super.key}) : bigScale = true;
  const InboxLauncherTile.small({super.key}) : bigScale = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => openEmailApp(context),
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neutral_03, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(bigScale ? 16 : 8),
        child: Row(
          children: [
            SvgPicture.asset(
              AppIcons.inbox,
              width: bigScale ? 64 : 52,
              height: bigScale ? 64 : 52,
              // ignore: deprecated_member_use
              color: AppColors.neutral_06,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localization(
                      context,
                    ).authForgotPasswordCheckInboxOpenInboxHeadline,
                    style:
                        bigScale
                            ? AppTextStyles.headline7.copyWith(
                              color: AppColors.neutral_06,
                            )
                            : AppTextStyles.body2Semi.copyWith(
                              color: AppColors.neutral_06,
                            ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    localization(
                      context,
                    ).authForgotPasswordCheckInboxOpenInboxCaption,
                    style: AppTextStyles.caption2.copyWith(
                      color: AppColors.neutral_04,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SvgPicture.asset(
              getValueWithDirection(
                context,
                AppIcons.backRtl,
                AppIcons.backLtr,
              ),
              width: 20,
              height: 20,
              // ignore: deprecated_member_use
              color: AppColors.neutral_04.withAlpha(191),
            ),
          ],
        ),
      ),
    );
  }
}

void openEmailApp(BuildContext context) async {
  if (Platform.isAndroid) {
    AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.MAIN',
      category: 'android.intent.category.APP_EMAIL',
      flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
    );

    intent.launch();
  } else if (Platform.isIOS) {
    launchUrl(Uri.parse('message://'));
  }
}
