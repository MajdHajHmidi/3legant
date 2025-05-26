import '../../../core/widgets/app_circular_progress_indicator.dart';
import '../widgets/home_header.dart';
import '../widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/data/auth_repo.dart';
import '../../../core/util/dependency_injection.dart';
import '../../../core/util/localization.dart';
import '../../../core/widgets/async_retry.dart';
import '../../cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final cubit = context.read<HomeCubit>();

                  return AsyncValueBuilder(
                    value: cubit.homeDataModel,
                    loading:
                        (context) =>
                            Center(child: AppCircularProgressIndicator()),
                    data:
                        (context, data) => BlocProvider.value(
                          value: cubit,
                          child: HomeWidget(
                            homeDataModel: cubit.homeDataModel.data!,
                          ),
                        ),
                    error:
                        (context, error) => Center(
                          child: AsyncRetryWidget(
                            message: localization(
                              context,
                            ).rpcError(cubit.homeDataModel.error!.code),
                            onPressed: () {
                              final user =
                                  serviceLocator<AuthRepo>()
                                      .getCurrentUser()
                                      ?.id;

                              if (user != null) {
                                context.read<HomeCubit>().getHomeData(user);
                              }
                            },
                          ),
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
