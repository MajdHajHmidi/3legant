import '../widgets/states/home_error_view.dart';
import '../widgets/states/home_loading_view.dart';

import '../widgets/home_header.dart';
import '../widgets/states/home_data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';

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
                buildWhen: (_, state) => state is HomeDataChangedState,
                builder: (context, state) {
                  final cubit = context.read<HomeCubit>();

                  return AsyncValueBuilder(
                    value: cubit.homeDataModel,
                    loading: (context) => HomeLoadingView(),
                    data:
                        (context, data) => BlocProvider.value(
                          value: cubit,
                          child: HomeDataView(
                            homeDataModel: cubit.homeDataModel.data!,
                          ),
                        ),
                    error:
                        (context, error) => BlocProvider.value(
                          value: cubit,
                          child: HomeErrorView(
                            failure: cubit.homeDataModel.error!,
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
