import 'package:e_commerce/auth/data/auth_repo.dart';
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:e_commerce/core/util/dependency_injection.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/async_retry.dart';
import 'package:e_commerce/profile/presentation/cubits/profile_screen_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileErrorView extends StatelessWidget {
  final AppFailure failure;
  const ProfileErrorView({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AsyncRetryWidget(
        message: localization(context).rpcError(failure.code),
        onPressed: () {
          final userId = serviceLocator<AuthRepo>().getCurrentUser()?.id;

          if (userId != null) {
            context.read<ProfileScreenDataCubit>().getData(userId: userId);
          }
        },
      ),
    );
  }
}
