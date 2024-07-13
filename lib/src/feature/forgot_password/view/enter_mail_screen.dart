import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:safebump/src/feature/forgot_password/logic/cubit/enter_mail_bloc.dart';
import 'package:safebump/src/feature/forgot_password/logic/state/enter_mail_state.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/widget/button/fill_button.dart';
import 'package:safebump/widget/text_field/text_field_with_label.dart';

class EnterMailScreen extends StatelessWidget {
  const EnterMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => AppCoordinator.pop(),
        ),
      ),
      backgroundColor: AppColors.white4,
      body: DismissKeyBoard(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30),
          child: Column(
            children: [
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              _renderLogoApp(),
              _renderTitle(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p20),
              _renderSubTitle(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              _renderEmailField(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p30),
              _renderSendButton(context),
              XPaddingUtils.verticalPadding(height: AppPadding.p15),
            ],
          ),
        )),
      ),
    );
  }

  Widget _renderLogoApp() {
    return Assets.images.images.logo.image(width: AppSize.s200);
  }

  Widget _renderTitle(BuildContext context) {
    return Text(
      S.of(context).forgotPasswordUppercase,
      style: const TextStyle(
          fontFamily: FontFamily.productSans,
          fontSize: AppFontSize.f24,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _renderSubTitle(BuildContext context) {
    return Text(
      S.of(context).enterYourEmailWe,
      textAlign: TextAlign.center,
      style: AppTextStyle.labelStyle.copyWith(color: AppColors.black2),
    );
  }

  Widget _renderEmailField(BuildContext context) {
    return BlocBuilder<EnterMailBloc, EnterMailState>(
      buildWhen: (previous, current) =>
          previous.mailValidated != current.mailValidated,
      builder: (context, state) {
        return XTextFieldWithLabel(
            onChanged: (email) =>
                context.read<EnterMailBloc>().onEmailChanged(email),
            hintText: S.of(context).yourEmail,
            hintStyle: AppTextStyle.hintTextStyle,
            errorText: StringUtils.isNullOrEmpty(state.mailValidated)
                ? null
                : state.mailValidated,
            prefix: const Icon(
              Icons.mail_outline,
              size: AppSize.s14,
              color: AppColors.hintTextColor,
            ));
      },
    );
  }

  Widget _renderSendButton(BuildContext context) {
    return BlocSelector<EnterMailBloc, EnterMailState, EnterMailStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        return XFillButton(
            onPressed: () =>
                context.read<EnterMailBloc>().onTapSendEmail(context),
            borderRadius: AppRadius.r10,
            isLoading: status == EnterMailStatus.onProcess,
            label: Text(
              S.of(context).sendCode,
              style: AppTextStyle.buttonTextStylePrimary,
            ));
      },
    );
  }
}
