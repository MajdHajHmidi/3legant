import 'package:e_commerce/profile/presentation/cubits/profile_details_update_cubit.dart';
import 'package:e_commerce/profile/presentation/cubits/profile_screen_data_cubit.dart';
import 'package:flutter/material.dart';

class ProfileController {
  final ProfileDetailsUpdateCubit profileDetailsUpdateCubit;
  final ProfileScreenDataCubit profileScreenDataCubit;
  ProfileController({
    required this.profileDetailsUpdateCubit,
    required this.profileScreenDataCubit,
  }) {
    profileDetailsUpdateCubit.stream.listen((state) {
      if (state.isData) {
        // Update UI when request to change user name succeeds
        profileScreenDataCubit.updateUsername(state.data!);
      }
    });
  }

  final profileNameTextController = TextEditingController();

  void updateAccountDetails() {
    // Make request to database
    profileDetailsUpdateCubit.updateAccountDetails(
      username: profileNameTextController.text,
    );
  }

  void dispose() {
    profileNameTextController.dispose();
  }
}
