import 'dart:async';
import 'package:e_commerce/auth/cubit/auth_cubit.dart';
import 'package:e_commerce/core/constants/assets.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/duration_extension.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/core/widgets/app_checkbox.dart';
import 'package:e_commerce/core/widgets/app_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthSignupScreen extends StatefulWidget {
  const AuthSignupScreen({super.key});

  @override
  State<AuthSignupScreen> createState() => _AuthSignupScreenState();
}

class _AuthSignupScreenState extends State<AuthSignupScreen>
    with TickerProviderStateMixin {
  late final AnimationController titleAnimationController;
  late final AnimationController contentAnimationController;

  late final Animation<Offset> titleSlideAnimation;
  late final Animation<Offset> contentSlideAnimation;
  late final Animation<double> contentFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Define animation curves
    const titleAnimationCurve = Curves.fastOutSlowIn;
    const contentAniamtionCurve = Curves.easeOut;

    // Define animation controllers
    titleAnimationController = AnimationController(
      vsync: this,
      duration: 500.ms,
    );
    contentAnimationController = AnimationController(
      vsync: this,
      duration: 500.ms,
    );

    // Define animations
    titleSlideAnimation = Tween(
      begin: Offset(-0.8, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: titleAnimationController,
        curve: titleAnimationCurve,
      ),
    );

    contentSlideAnimation = Tween(
      begin: Offset(0, 0.05),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: contentAnimationController,
        curve: contentAniamtionCurve,
      ),
    );

    contentFadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: contentAnimationController,
        curve: contentAniamtionCurve,
      ),
    );

    // Start first animation
    titleAnimationController.forward();
    // Start second animation after 3/5 of the time it takes to complete the first animation
    Timer(
      (titleAnimationController.duration!.inMilliseconds * 3 / 5).round().ms,
      () => contentAnimationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SlideTransition(
            position: titleSlideAnimation,
            child: Text(
              localization(context).authSignUp,
              style: AppTextStyles.headline4,
            ),
          ),
          const SizedBox(height: 16),
          FadeTransition(
            opacity: contentFadeAnimation,
            child: SlideTransition(
              position: contentSlideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '${localization(context).authAlreadyHaveAnAccount} ',
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.neutral_04,
                          ),
                        ),
                        TextSpan(
                          text: localization(context).authSignIn,
                          style: AppTextStyles.body2Semi.copyWith(
                            color: AppColors.green,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap =
                                    () => context
                                        .read<AuthCubit>()
                                        .changeViewMode(AuthViewMode.signin),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: cubit.signupFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextFormField(
                          hint: localization(context).authFieldYourName,
                          controller: cubit.nameFieldController,
                          textInputAction: TextInputAction.next,
                          validator: (value) => cubit.validateName(context),
                        ),
                        const SizedBox(height: 32),
                        AppTextFormField(
                          hint: localization(context).authFieldEmail,
                          controller: cubit.emailFieldController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => cubit.validateEmail(context),
                        ),
                        const SizedBox(height: 32),
                        BlocBuilder<AuthCubit, AuthState>(
                          buildWhen:
                              (_, state) =>
                                  state is AuthSignupHidePasswordToggledState,
                          builder: (context, state) {
                            final cubit = context.read<AuthCubit>();

                            return AppTextFormField(
                              hint: localization(context).authFieldPassword,
                              controller: cubit.signupPasswordFieldController,
                              textInputAction: TextInputAction.next,
                              validator:
                                  (value) =>
                                      cubit.validateSignupPassword(context),
                              obscure: cubit.isSignupPasswordHidden,
                              suffixIcon: Container(
                                width: 26,
                                height: 26,
                                alignment: Alignment.centerRight,
                                child: SvgPicture.asset(
                                  cubit.isSignupPasswordHidden
                                      ? AppIcons.eye
                                      : AppIcons.strikedEye,
                                  theme: SvgTheme(
                                    currentColor: AppColors.neutral_04,
                                  ),
                                  width: 26,
                                  height: 26,
                                ),
                              ),
                              onSuffixIconPressed:
                                  cubit.toggleSignupPasswordVisibility,
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                        AppTextFormField(
                          hint: localization(context).authFieldConfirmPassword,
                          controller:
                              cubit.signupConfirmPasswordFieldController,
                          onFieldSubmitted:
                              (value) =>
                                  cubit.signupWithEmailAndPassword(context),
                          validator:
                              (value) => cubit
                                  .validateSignupPasswordConfirmation(context),
                          obscure: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      BlocBuilder<AuthCubit, AuthState>(
                        buildWhen:
                            (_, state) =>
                                state is AuthPrivacyPolicyToggledState,
                        builder: (context, state) {
                          return AppCheckbox(
                            value: cubit.isPrivacyPolicyAccepted,
                            onChanged: (value) => cubit.togglePrivacyPolicy(),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${localization(context).authAgreeWith} ',
                                style: AppTextStyles.caption2.copyWith(
                                  color: AppColors.neutral_04,
                                ),
                              ),
                              TextSpan(
                                text: localization(context).authPrivacyPolicy,
                                style: AppTextStyles.caption2Semi.copyWith(
                                  color: AppColors.neutral_07,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap =
                                          () =>
                                              cubit.launchPrivacyPolicyWebpage(
                                                context,
                                              ),
                              ),
                              TextSpan(
                                text: ' ${localization(context).authAnd} ',
                                style: AppTextStyles.caption2.copyWith(
                                  color: AppColors.neutral_04,
                                ),
                              ),
                              TextSpan(
                                text: localization(context).authTermsOfUse,
                                style: AppTextStyles.caption2Semi.copyWith(
                                  color: AppColors.neutral_07,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap =
                                          () => cubit.launchTermsOfUseWebpage(
                                            context,
                                          ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen:
                        (_, state) =>
                            state is AuthPrivacyPolicyToggledState ||
                            state is AuthEmailSignupLoadingState ||
                            state is AuthEmailSignupSuccessState ||
                            state is AuthEmailSignupErrorState,
                    builder: (context, state) {
                      final cubit = context.read<AuthCubit>();

                      return AppButton(
                        onPressed:
                            cubit.isPrivacyPolicyAccepted
                                ? () =>
                                    cubit.signupWithEmailAndPassword(context)
                                : null,
                        loading: cubit.emailSignupLoading,
                        text: localization(context).authSignUp,
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Flexible(
                        child: Divider(
                          thickness: 1,
                          height: 0,
                          color: AppColors.neutral_03,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          localization(context).authOr,
                          style: AppTextStyles.caption2Semi.copyWith(
                            color: AppColors.neutral_05,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Divider(
                          thickness: 1,
                          height: 0,
                          color: AppColors.neutral_03,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen:
                        (_, state) =>
                            state is AuthPrivacyPolicyToggledState ||
                            state is AuthGoogleSignupLoadingState ||
                            state is AuthGoogleSignupSuccessState ||
                            state is AuthGoogleSignupErrorState,
                    builder: (context, state) {
                      final cubit = context.read<AuthCubit>();

                      return AppButton(
                        onPressed:
                            cubit.isPrivacyPolicyAccepted
                                ? () => cubit.signupWithGoogle(context)
                                : null,
                        text: localization(context).authSignupWithGoogle,
                        loading: cubit.googleSignupLoading,
                        lightTheme: true,
                        prefixIcon: SvgPicture.asset(AppIcons.google),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
