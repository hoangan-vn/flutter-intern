import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:safebump/src/config/constant/app_constant.dart';
import 'package:safebump/src/config/enum/baby_type_enum.dart';
import 'package:safebump/src/feature/add_baby/logic/cubit/add_baby_bloc.dart';
import 'package:safebump/src/feature/add_baby/logic/state/add_baby_state.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/datetime_ext.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/src/utils/utils.dart';
import 'package:safebump/widget/button/bottom_buttons.dart';
import 'package:safebump/widget/button/button_with_label.dart';
import 'package:safebump/widget/button/circle_button.dart';
import 'package:safebump/widget/button/dropdown_button.dart';
import 'package:safebump/widget/text_field/text_field_with_label.dart';

class AddBabyScreen extends StatelessWidget {
  const AddBabyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white3,
      body: DismissKeyBoard(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                XPaddingUtils.verticalPadding(height: AppPadding.p59),
                _renderTitle(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p45),
                _renderAddImage(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p20),
                _renderNameField(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p20),
                _renderGender(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p20),
                _renderBirthDateTime(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p20),
                _renderBabyBody(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p20),
                _renderBirthExperience(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p10),
                _renderBottomButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderTitle(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          S.of(context).happParenting,
          style: const TextStyle(
              fontFamily: FontFamily.inter,
              fontWeight: FontWeight.w700,
              fontSize: AppFontSize.f24),
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p10),
        Text(
          S.of(context).tellMeMoreAbout,
          style: const TextStyle(
              fontFamily: FontFamily.inter, fontSize: AppFontSize.f14),
        )
      ],
    );
  }

  Widget _renderAddImage(BuildContext context) {
    return XCircleButton(
        buttonLabelBottom: S.of(context).babysPicture,
        onTapped: () {
        });
  }

  Widget _renderNameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: BlocBuilder<AddBabyBloc, AddBabyState>(
        buildWhen: (previous, current) =>
            previous.errorBabyName != current.errorBabyName,
        builder: (context, state) {
          return XTextFieldWithLabel(
              labelStyle: AppTextStyle.labelStyle,
              hintStyle: AppTextStyle.hintTextStyle,
              errorText: StringUtils.isNullOrEmpty(state.errorBabyName)
                  ? null
                  : state.errorBabyName,
              hintText: S.of(context).babysName,
              label: S.of(context).name,
              onChanged: (text) {
                context.read<AddBabyBloc>().onChangedBabyName(text);
              });
        },
      ),
    );
  }

  Widget _renderGender(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: BlocSelector<AddBabyBloc, AddBabyState, Gender>(
          selector: (state) => state.gender,
          builder: (context, gender) {
            return XDropdownButton<Gender>(
                labelStyle: AppTextStyle.labelStyle,
                label: S.of(context).gender,
                value: gender,
                items: AppConstant.getListGender(context),
                onChanged: (value) {
                  context
                      .read<AddBabyBloc>()
                      .onChangedBabyGender(value ?? Gender.male);
                });
          },
        ));
  }

  Widget _renderBirthDateTime(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            _renderBirthDate(context),
            XPaddingUtils.horizontalPadding(width: AppPadding.p10),
            _renderBirthTime(context),
          ],
        ));
  }

  Widget _renderBottomButton(BuildContext context) {
    return BlocSelector<AddBabyBloc, AddBabyState, AddBabyScreenStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        return XBottomButtons(
            positiveButtonText: S.of(context).save,
            cancelButtonText: S.of(context).cancel,
            isLoading: status == AddBabyScreenStatus.saving,
            onTappedPositive: () {
              context.read<AddBabyBloc>().saveBabyInfor(context);
            },
            onTappedCancel: () {
              AppCoordinator.pop();
            });
      },
    );
  }

  Widget _renderBirthDate(BuildContext context) {
    return Expanded(
        child: BlocBuilder<AddBabyBloc, AddBabyState>(
      buildWhen: (previous, current) =>
          previous.babyBirthDate != current.babyBirthDate ||
          previous.errorBabyBirthDate != current.errorBabyBirthDate,
      builder: (context, state) {
        return XLabelButton(
          onTapped: () async {
            context.read<AddBabyBloc>().showBottomSheetDateTimePicker(context,
                title: S.of(context).selectDate,
                type: DateTimePickerType.date,
                onChanged: (babyBirthDate) => context
                    .read<AddBabyBloc>()
                    .onChangedBabyBirthDate(babyBirthDate));
          },
          hint: S.of(context).selectDate,
          hintStyle: AppTextStyle.hintTextStyle,
          label: S.of(context).dateOfBirth,
          value: isNullOrEmpty(state.babyBirthDate)
              ? null
              : state.babyBirthDate!.toMMMdy,
          icon: Icons.calendar_today_outlined,
          labelStyle: AppTextStyle.labelStyle,
        );
      },
    ));
  }

  Widget _renderBirthTime(BuildContext context) {
    return Expanded(
        child: BlocBuilder<AddBabyBloc, AddBabyState>(
      buildWhen: (previous, current) =>
          previous.babyBirthTime != current.babyBirthTime ||
          previous.errorBabyBirthTime != current.errorBabyBirthTime,
      builder: (context, state) {
        return XLabelButton(
          onTapped: () async {
            context.read<AddBabyBloc>().showBottomSheetDateTimePicker(context,
                title: S.of(context).selectTime,
                type: DateTimePickerType.time,
                onChanged: (babyBirthTime) => context
                    .read<AddBabyBloc>()
                    .onChangedBabyBirthTime(babyBirthTime));
          },
          hint: S.of(context).selectTime,
          hintStyle: AppTextStyle.hintTextStyle,
          label: S.of(context).timeOfBirth,
          icon: Icons.access_time,
          value: isNullOrEmpty(state.babyBirthTime)
              ? null
              : state.babyBirthTime!.toHHmm,
          labelStyle: AppTextStyle.labelStyle,
        );
      },
    ));
  }

  Widget _renderBabyBody(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            _renderBabyWeight(context),
            XPaddingUtils.horizontalPadding(width: AppPadding.p10),
            _renderBabyHeight(context),
          ],
        ));
  }

  Widget _renderBabyWeight(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AddBabyBloc, AddBabyState>(
        buildWhen: (previous, current) =>
            previous.errorBirthWeight != current.errorBirthWeight,
        builder: (context, state) {
          return XTextFieldWithLabel(
            label: S.of(context).birthWeight,
            labelStyle: AppTextStyle.labelStyle,
            hintText: S.of(context).birthWeight,
            hintStyle: AppTextStyle.hintTextStyle,
            errorText: StringUtils.isNullOrEmpty(state.errorBirthWeight)
                ? null
                : state.errorBirthWeight,
            suffix: _renderUnit(S.of(context).kg),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              context
                  .read<AddBabyBloc>()
                  .onChangedBabyWeight(double.parse(value));
            },
          );
        },
      ),
    );
  }

  Widget _renderBabyHeight(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AddBabyBloc, AddBabyState>(
        buildWhen: (previous, current) =>
            previous.errorBirthHeight != current.errorBirthHeight,
        builder: (context, state) {
          return XTextFieldWithLabel(
            keyboardType: TextInputType.number,
            label: S.of(context).birthHeight,
            labelStyle: AppTextStyle.labelStyle,
            hintText: S.of(context).birthHeight,
            hintStyle: AppTextStyle.hintTextStyle,
            errorText: StringUtils.isNullOrEmpty(state.errorBirthHeight)
                ? null
                : state.errorBirthHeight,
            suffix: _renderUnit(S.of(context).cm),
            onChanged: (value) {
              context
                  .read<AddBabyBloc>()
                  .onChangedBabyHeight(double.parse(value));
            },
          );
        },
      ),
    );
  }

  Widget _renderUnit(String unit) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          unit,
          style: AppTextStyle.labelStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _renderBirthExperience(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: XDropdownButton(
            labelStyle: AppTextStyle.labelStyle,
            label: S.of(context).birthExperience,
            items: [DropdownMenuItem(child: Text(S.of(context).cSection))],
            onChanged: (value) {}));
  }
}
