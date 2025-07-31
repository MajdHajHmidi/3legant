import 'package:e_commerce/core/constants/app_assets.dart';
import 'package:e_commerce/core/constants/app_constants.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/app_dropdown.dart';
import 'package:e_commerce/core/widgets/app_image.dart';
import 'package:e_commerce/profile/domain/profile_data_model.dart';
import 'package:e_commerce/profile/presentation/cubits/profile_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreenHeader extends StatelessWidget {
  final ProfileDataModel screenDataModel;
  const ProfileScreenHeader({super.key, required this.screenDataModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          localization(context).myAccount,
          style: AppTextStyles.headline4.copyWith(color: AppColors.neutral_07),
        ),
        SizedBox(height: 40),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          decoration: BoxDecoration(
            color: AppColors.neutral_02.withAlpha(127),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: AppNetworkImage(
                        imageUrl:
                            screenDataModel.accountDetails.profileImage ??
                            AppConstants.userAvatarPlaceholderImageUrl,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: getValueWithDirection(context, 0.0, null),
                      left: getValueWithDirection(context, null, 0.0),
                      child: Container(
                        width: 30,
                        height: 30,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.neutral_07,
                          border: Border.all(
                            width: 1.5,
                            color: AppColors.neutral_01,
                          ),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.camera,
                          // ignore: deprecated_member_use
                          color: AppColors.neutral_01,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Text(
                screenDataModel.accountDetails.displayName,
                style: AppTextStyles.body1Semi.copyWith(
                  color: AppColors.neutral_07,
                ),
              ),
              SizedBox(height: 40),
              BlocBuilder<ProfileViewCubit, ProfileViewMode>(
                builder: (context, state) {
                  final dropdownItems = {
                    ProfileViewMode.accountDetails:
                        localization(context).accountDetails,
                    ProfileViewMode.orders: localization(context).orders,
                    ProfileViewMode.favorites: localization(context).favorites,
                  };

                  return AppDropdownButton<ProfileViewMode>(
                    value: state,
                    items: dropdownItems,
                    backgroundColor: AppColors.neutral_01,
                    onChanged:
                        (value) => context
                            .read<ProfileViewCubit>()
                            .changeProfileViewMode(
                              value ?? ProfileViewMode.accountDetails,
                            ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
