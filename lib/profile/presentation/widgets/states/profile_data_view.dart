import 'package:e_commerce/core/widgets/sliver_util.dart';
import 'package:e_commerce/profile/domain/profile_data_model.dart';
import 'package:e_commerce/profile/presentation/cubits/profile_view_cubit.dart';
import 'package:e_commerce/profile/presentation/widgets/profile_account_details.dart';
import 'package:e_commerce/profile/presentation/widgets/profile_favorites.dart';
import 'package:e_commerce/profile/presentation/widgets/profile_orders.dart';
import 'package:e_commerce/profile/presentation/widgets/profile_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_center/sliver_center.dart';

class ProfileDataView extends StatelessWidget {
  final ProfileDataModel screenDataModel;
  const ProfileDataView({super.key, required this.screenDataModel});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverConstrainedCrossAxis(
          maxExtent: 700,
          sliver: SliverCenter(
            sliver: SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              sliver: SliverMainAxisGroup(
                slivers: [
                  SliverIndent(height: 16),
                  SliverToBoxAdapter(
                    child: ProfileScreenHeader(
                      screenDataModel: screenDataModel,
                    ),
                  ),
                  SliverIndent(height: 40),
                  BlocBuilder<ProfileViewCubit, ProfileViewMode>(
                    builder: (context, state) {
                      if (state == ProfileViewMode.accountDetails) {
                        return ProfileAccountDetails(
                          accountDetails: screenDataModel.accountDetails,
                        );
                      } else if (state == ProfileViewMode.orders) {
                        return ProfileOrders(orders: screenDataModel.orders);
                      } else if (state == ProfileViewMode.favorites) {
                        return ProfileFavorites(
                          products: screenDataModel.favoriteProducts,
                        );
                      }

                      return SliverIndent();
                    },
                  ),
                  SliverIndent(height: 32),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
