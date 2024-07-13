import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:safebump/src/feature/sign_up/logic/sign_up_bloc.dart';
import 'package:safebump/src/feature/sign_up/logic/sign_up_state.dart';
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

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

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
              _renderSignUpSection(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p15),
              _renderSignInSection(context),
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

  Widget _renderSignUpSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _renderNameField(context),
        XPaddingUtils.verticalPadding(height: AppPadding.p10),
        _renderEmailField(context),
        XPaddingUtils.verticalPadding(height: AppPadding.p10),
        _renderPasswordField(context),
        XPaddingUtils.verticalPadding(height: AppPadding.p30),
        _renderSignUpButton(context),
      ],
    );
  }

  Widget _renderNameField(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (pre, cur) => pre.nameValidated != cur.nameValidated,
      builder: (context, state) {
        return XTextFieldWithLabel(
            onChanged: (name) => context.read<SignUpBloc>().onChangedName(name),
            label: S.of(context).enterYourName,
            hintText: S.of(context).enterHere,
            errorText: StringUtils.isNullOrEmpty(state.nameValidated)
                ? null
                : state.nameValidated,
            suffix: const Icon(
              Icons.person_outline,
              size: AppSize.s14,
              color: AppColors.hintTextColor,
            ));
      },
    );
  }

  Widget _renderEmailField(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (pre, cur) => pre.emailValidated != cur.emailValidated,
      builder: (context, state) {
        return XTextFieldWithLabel(
            onChanged: (email) =>
                context.read<SignUpBloc>().onChangedEmail(email),
            label: S.of(context).enterYourEmail,
            hintText: S.of(context).pk3076889,
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
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (pre, cur) =>
          pre.passwordValidated != cur.passwordValidated ||
          pre.isShowPassword != cur.isShowPassword,
      builder: (context, state) {
        return XTextFieldWithLabel(
            onChanged: (pass) =>
                context.read<SignUpBloc>().onChangedPassword(pass),
            label: S.of(context).createYourPassword,
            hintText: S.of(context).enterHere,
            errorText: StringUtils.isNullOrEmpty(state.passwordValidated)
                ? null
                : state.passwordValidated,
            isObscureText: state.isShowPassword,
            suffix: IconButton(
              icon: Icon(
                state.isShowPassword ? Icons.visibility_off : Icons.visibility,
                size: AppSize.s14,
                color: AppColors.hintTextColor,
              ),
              onPressed: () => context.read<SignUpBloc>().isShowPassword(),
            ));
      },
    );
  }

  Widget _renderSignUpButton(BuildContext context) {
    return BlocSelector<SignUpBloc, SignUpState, SignUpStatus>(
      selector: (state) {
        return state.status;
      },
      builder: (context, status) {
        return XFillButton(
            onPressed: () =>
                context.read<SignUpBloc>().signupWithEmail(context),
            borderRadius: AppRadius.r10,
            label: status == SignUpStatus.signingIn
                ? _renderCircularProgressIndicator(AppColors.white)
                : Text(
                    S.of(context).signUp,
                    style: AppTextStyle.buttonTextStylePrimary,
                  ));
      },
    );
  }

  Widget _renderSignInSection(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).alreadyHaveAccount,
          style: AppTextStyle.labelStyle,
        ),
        XTextButton(
          callback: () => AppCoordinator.showSignInScreen(),
          label: S.of(context).login,
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
    return BlocSelector<SignUpBloc, SignUpState, SignUpStatus>(
      selector: (state) {
        return state.status;
      },
      builder: (context, status) {
        return XFillButton(
            bgColor: AppColors.white,
            border: const BorderSide(color: AppColors.grey2, width: 0.5),
            borderRadius: AppRadius.r10,
            onPressed: () =>
                context.read<SignUpBloc>().signUpWithGoogle(context),
            label: status == SignUpStatus.signingIn
                ? _renderCircularProgressIndicator(AppColors.black)
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
                  ));
      },
    );
  }

  Widget _renderCircularProgressIndicator(Color strokeColor) {
    return SizedBox(
      width: AppSize.s20,
      height: AppSize.s20,
      child: CircularProgressIndicator(
        color: strokeColor,
        strokeWidth: AppSize.s2,
      ),
    );
  }
}
