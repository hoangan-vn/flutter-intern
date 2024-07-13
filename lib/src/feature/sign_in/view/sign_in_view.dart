import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:safebump/src/feature/sign_in/logic/sign_in_bloc.dart';
import 'package:safebump/src/feature/sign_in/logic/sign_in_state.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/widget/button/fill_button.dart';
import 'package:safebump/widget/button/text_button.dart';
import 'package:safebump/widget/text_field/text_field_with_label.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white4,
      body: DismissKeyBoard(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30),
          child: Column(
            children: [
              XPaddingUtils.verticalPadding(height: AppPadding.p53),
              _renderLogoApp(),
              _renderSignInSection(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p15),
              _renderSignUpSection(context),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p23),
                child: Text(
                  S.of(context).or.toUpperCase(),
                  style: AppTextStyle.labelStyle,
                ),
              ),
              _renderSocialSignInSection(context),
            ],
          ),
        )),
      ),
    );
  }

  Widget _renderLogoApp() {
    return Assets.images.images.logo.image(width: AppSize.s200);
  }

  Widget _renderSignInSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _renderEmailField(context),
        XPaddingUtils.verticalPadding(height: AppPadding.p10),
        _renderPasswordField(context),
        _renderForgotPasswordButton(context),
        XPaddingUtils.verticalPadding(height: AppPadding.p30),
        _renderLoginButton(context),
      ],
    );
  }

  Widget _renderEmailField(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) =>
          previous.emailValidated != current.emailValidated,
      builder: (context, state) {
        return XTextFieldWithLabel(
            onChanged: (email) =>
                context.read<SignInBloc>().onChangedEmail(email),
            label: S.of(context).email,
            hintText: S.of(context).enterHere,
            errorText: StringUtils.isNullOrEmpty(state.emailValidated)
                ? null
                : state.emailValidated,
            suffix: const Icon(
              Icons.mail_outline,
              size: AppSize.s14,
              color: AppColors.hintTextColor,
            ));
      },
    );
  }

  Widget _renderPasswordField(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) =>
          previous.passwordValidated != current.passwordValidated ||
          previous.isShowPassword != current.isShowPassword,
      builder: (context, state) {
        return XTextFieldWithLabel(
            onChanged: (pass) =>
                context.read<SignInBloc>().onChangedPassword(pass),
            label: S.of(context).password,
            errorText: StringUtils.isNullOrEmpty(state.passwordValidated)
                ? null
                : state.passwordValidated,
            hintText: S.of(context).enterHere,
            isObscureText: state.isShowPassword,
            suffix: IconButton(
              icon: Icon(
                state.isShowPassword ? Icons.visibility : Icons.visibility_off,
                size: AppSize.s14,
                color: AppColors.hintTextColor,
              ),
              onPressed: () => context.read<SignInBloc>().isShowPassword(),
            ));
      },
    );
  }

  Widget _renderForgotPasswordButton(BuildContext context) {
    return XTextButton(
      label: S.of(context).forgotPassword,
      callback: () => AppCoordinator.showEnterMailScreen(),
    );
  }

  Widget _renderLoginButton(BuildContext context) {
    return BlocSelector<SignInBloc, SignInState, SignInStatus>(
      selector: (state) {
        return state.status;
      },
      builder: (context, state) {
        return XFillButton(
            onPressed: () => context.read<SignInBloc>().loginWithEmail(context),
            borderRadius: AppRadius.r10,
            label: state == SignInStatus.signingIn
                ? const SizedBox(
                    width: AppSize.s20,
                    height: AppSize.s20,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: AppSize.s2,
                    ),
                  )
                : Text(
                    S.of(context).login,
                    style: AppTextStyle.buttonTextStylePrimary,
                  ));
      },
    );
  }

  Widget _renderSignUpSection(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).dontHaveAccount,
          style: AppTextStyle.labelStyle,
        ),
        XTextButton(
          callback: () => AppCoordinator.showSignUpScreen(),
          label: S.of(context).signUp,
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        )
      ],
    );
  }

  Widget _renderSocialSignInSection(BuildContext context) {
    return Column(
      children: [
        _renderGGSignUp(context),
        XPaddingUtils.verticalPadding(height: AppPadding.p16),
        XPaddingUtils.verticalPadding(height: AppPadding.p16),
      ],
    );
  }

  Widget _renderGGSignUp(BuildContext context) {
    return BlocSelector<SignInBloc, SignInState, SignInStatus>(
        selector: (state) => state.status,
        builder: (context, status) => XFillButton(
            bgColor: AppColors.white,
            border: const BorderSide(color: AppColors.grey2, width: 0.5),
            borderRadius: AppRadius.r10,
            onPressed: () =>
                context.read<SignInBloc>().loginWithGoogle(context),
            label: status == SignInStatus.signingIn
                ? const SizedBox(
                    width: AppSize.s20,
                    height: AppSize.s20,
                    child: CircularProgressIndicator(
                      color: AppColors.black,
                      strokeWidth: AppSize.s2,
                    ),
                  )
                : Row(
                    children: [
                      Assets.images.images.ggLogo.image(),
                      XPaddingUtils.horizontalPadding(width: AppPadding.p15),
                      Text(
                        S.of(context).signUpWithGG,
                        style: const TextStyle(
                            fontSize: AppFontSize.f14,
                            fontFamily: FontFamily.productSans,
                            color: AppColors.black),
                      )
                    ],
                  )));
  }
}
