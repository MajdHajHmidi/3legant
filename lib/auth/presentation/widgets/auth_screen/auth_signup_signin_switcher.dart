import '../../../cubit/auth_cubit.dart';
import '../../screens/auth_signin_screen.dart';
import '../../screens/auth_signup_screen.dart';
import '../../../../core/util/duration_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthSignupSigninSwitcher extends StatelessWidget {
  const AuthSignupSigninSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (_, state) => state is AuthViewModeChangedState,
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();

        return ClipRRect(
          // Prevent animation from interceding with other widgets with the same elevation
          clipBehavior: Clip.hardEdge,
          child: AnimatedSwitcher(
            duration: 300.ms,
            switchInCurve: Curves.fastOutSlowIn,
            switchOutCurve: Curves.fastOutSlowIn,
            layoutBuilder: (currentChild, previousChildren) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              );
            },
            transitionBuilder: (child, animation) {
              final currentChildKey = ValueKey(cubit.authViewMode);
              final isNewChild = child.key == currentChildKey;

              final rightPosition = Offset(1.0, 0.0);
              final leftPosition = Offset(-1.0, 0.0);

              // Determine the direction of the slide based on the transition.
              Offset beginOffset;
              if (cubit.authViewMode == AuthViewMode.signin) {
                // Going to Signin: Slide new child in from the right, old child out to the left
                beginOffset = isNewChild ? rightPosition : leftPosition;
              } else {
                // Going to Signup: Slide new child in from the left, old child out to the right
                beginOffset = isNewChild ? leftPosition : rightPosition;
              }
              final Offset endOffset = Offset.zero;

              final tween = Tween<Offset>(begin: beginOffset, end: endOffset);
              final offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            },
            child:
                cubit.authViewMode == AuthViewMode.signup
                    ? BlocProvider.value(
                      value: cubit,
                      key: ValueKey(AuthViewMode.signup),
                      child: const AuthSignupScreen(),
                    )
                    : BlocProvider.value(
                      value: cubit,
                      key: ValueKey(AuthViewMode.signin),
                      child: const AuthSigninScreen(),
                    ),
          ),
        );
      },
    );
  }
}
