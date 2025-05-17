import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/auth/presentation/widgets/inbox_launcher_tile.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckInboxView extends StatelessWidget {
  const CheckInboxView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localization(context).authForgotPasswordCheckInboxTitle,
              style: AppTextStyles.body2Semi.copyWith(
                color: AppColors.neutral_06,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              localization(context).authForgotPasswordCheckInboxSubtitle,
              style: AppTextStyles.caption2.copyWith(
                color: AppColors.neutral_04,
              ),
            ),
            const SizedBox(height: 40),
            InboxLauncherTile.big(),
          ],
        );
      },
    );
  }
}
