import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_callback_state.dart';

class LoginCallbackCubit extends Cubit<LoginCallbackState> {
  LoginCallbackCubit() : super(LoginCallbackInitial());

  late StreamSubscription supabaseAuthStateChanges;
  void initSupabaseAuthStateChanges() {
    supabaseAuthStateChanges = Supabase.instance.client.auth.onAuthStateChange
        .listen((state) {
          if (state.session != null) {
            emit(LoginCallbackSuccessState());
            return;
          }

          // emit(LoginCallbackFailureState());
        });
  }

  @override
  Future<void> close() {
    supabaseAuthStateChanges.cancel();
    return super.close();
  }
}
