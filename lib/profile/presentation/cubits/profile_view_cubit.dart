import 'package:flutter_bloc/flutter_bloc.dart';

enum ProfileViewMode { accountDetails, orders, favorites }

class ProfileViewCubit extends Cubit<ProfileViewMode> {
  ProfileViewCubit() : super(ProfileViewMode.accountDetails);

  void changeProfileViewMode(ProfileViewMode mode) => emit(mode);
}
