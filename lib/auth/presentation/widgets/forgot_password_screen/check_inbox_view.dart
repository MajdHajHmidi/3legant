import '../../cubit/auth_cubit.dart';
import '../inbox_launcher_tile.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/util/localization.dart';
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
