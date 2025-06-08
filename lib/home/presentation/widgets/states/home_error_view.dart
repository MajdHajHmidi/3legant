import 'package:e_commerce/auth/data/auth_repo.dart';
import 'package:e_commerce/core/util/app_failure.dart';
import 'package:e_commerce/core/util/dependency_injection.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/async_retry.dart';
import 'package:e_commerce/home/presentation/cubit/home_cubit.dart';
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
          final user = serviceLocator<AuthRepo>().getCurrentUser()?.id;

          if (user != null) {
            context.read<HomeCubit>().getHomeData(user);
          }
        },
      ),
    );
  }
}
