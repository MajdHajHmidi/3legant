import 'package:e_commerce/auth/data/auth_repo.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/dependency_injection.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/app_circular_progress_indicator.dart';
import 'package:e_commerce/core/widgets/async_retry.dart';
import 'package:e_commerce/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();

            return Center(
              child: AsyncValueBuilder(
                value: cubit.homeDataModel,
                loading: (context) => AppCircularProgressIndicator(),
                data:
                    (context, data) => Text(
                      cubit.homeDataModel.data!.metadata.appName,
                      style: AppTextStyles.headline2,
                    ),
                error:
                    (context, error) => AsyncRetryWidget(
                      message: localization(
                        context,
                      ).rpcError(cubit.homeDataModel.error!.code),
                      onPressed:
                          () => cubit.getHomeData(
                            serviceLocator<AuthRepo>().getCurrentUser()?.id ??
                                '',
                          ),
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}
