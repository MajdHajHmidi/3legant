import '../../../../auth/data/auth_repo.dart';
import '../../../../core/util/app_failure.dart';
import '../../../../core/util/dependency_injection.dart';
import '../../../../core/util/localization.dart';
import '../../../../core/widgets/async_retry.dart';
import '../../cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeErrorView extends StatelessWidget {
  final AppFailure failure;
  const HomeErrorView({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AsyncRetryWidget(
        message: localization(
          context,
        ).rpcError(failure.code),
        onPressed: () {
          final userId = serviceLocator<AuthRepo>().getCurrentUser()?.id;

          if (userId != null) {
            context.read<HomeCubit>().getHomeData(userId);
          }
        },
      ),
    );
  }
}
