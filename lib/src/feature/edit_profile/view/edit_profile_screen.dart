// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:safebump/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:safebump/src/config/enum/baby_type_enum.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/edit_profile/logic/edit_profile_bloc.dart';
import 'package:safebump/src/feature/edit_profile/logic/edit_profile_state.dart';
import 'package:safebump/src/feature/edit_profile/logic/picker_image.dart';
import 'package:safebump/src/feature/edit_profile/widget/image_picker_bottom_sheet.dart';
import 'package:safebump/src/feature/edit_profile/widget/ruler_bottom_sheet.dart';
import 'package:safebump/src/feature/edit_profile/widget/unit_segment.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/datetime_ext.dart';
import 'package:safebump/src/utils/measurement_utils.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/src/utils/utils.dart';
import 'package:safebump/widget/appbar/appbar_dashboard.dart';
import 'package:safebump/widget/avatar/avatar.dart';
import 'package:safebump/widget/button/button_with_label.dart';
import 'package:safebump/widget/button/text_button.dart';
import 'package:safebump/widget/radio/radio_list_tile.dart';
import 'package:safebump/widget/text_field/text_field_with_label.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<EditProfileBloc>().initalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: DismissKeyBoard(
        child: BlocListener<EditProfileBloc, EditProfileState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            switch (state.status) {
              case EditProfileStatus.loading:
                XToast.showLoading();
                break;
              case EditProfileStatus.fail:
                if (XToast.isShowLoading) XToast.hideLoading();
                break;
              case EditProfileStatus.success:
                if (XToast.isShowLoading) XToast.hideLoading();
                AppCoordinator.pop(true);
                break;
              default:
            }
          },
          child: SafeArea(
            child: Column(
              children: <Widget>[
                _renderAppBar(),
                _renderSeparatorAndAvatar(),
                Expanded(
                  child: _renderInforUser(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderAppBar() {
    return XAppBarDashboard(
        title: S.of(context).editProfile,
        leading: IconButton(
            onPressed: () {
              bool isProfileChanged =
                  !(context.read<EditProfileBloc>().state.user ==
                      context.read<EditProfileBloc>().userAfterEdit());
              if (isProfileChanged) {
                // If user has changed profile but they hasn't save
                context.read<EditProfileBloc>().showDialogUnsaved(context);
              } else {
                AppCoordinator.pop(false);
              }
            },
            icon: const Icon(
              Icons.arrow_back,
              size: AppSize.s30,
            )),
        action: XTextButton(
          label: S.of(context).save,
          callback: () {
            context.read<EditProfileBloc>().saveEdittedProfile(context);
          },
        ));
  }

  Widget _renderSeparatorAndAvatar() {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      child: Column(
        children: [
          XPaddingUtils.verticalPadding(height: AppPadding.p16),
          BlocSelector<EditProfileBloc, EditProfileState, Uint8List?>(
            selector: (state) {
              return state.avatar;
            },
            builder: (context, avatar) {
              return XAvatar(
                  key: UniqueKey(),
                  isEditable: true,
                  memoryData: avatar,
                  name: context.read<EditProfileBloc>().state.name,
                  imageType: ImageType.memory,
                  onEdit: () {
                    pickImagehandler(context, avatar);
                  });
            },
          ),
          XPaddingUtils.verticalPadding(height: AppPadding.p16),
        ],
      ),
    );
  }

  void pickImagehandler(BuildContext context, Uint8List? avatar) {
    showCupertinoModalBottomSheet(
        duration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeOut,
        barrierColor: AppColors.black.withOpacity(0.5),
        context: context,
        builder: (_) => XImagePickerBottomSheet(
            isPhotoExisted: !isNullOrEmpty(avatar),
            onSelectedValue: (value) async {
              AppCoordinator.pop();
              switch (value as String) {
                case 'Take photo':
                  try {
                    final image = await PickerImageApp.show(ImageSource.camera);
                    if (image != null) {
                      context.read<EditProfileBloc>().setAvatar(image.bytes);
                    }
                  } catch (error) {
                    xLog.e("pickImagehandler $error");
                  }
                  break;
                case 'Choose photo':
                  try {
                    final image =
                        await PickerImageApp.show(ImageSource.gallery);
                    if (image != null) {
                      context.read<EditProfileBloc>().setAvatar(image.bytes);
                    }
                  } catch (error) {
                    xLog.e("pickImagehandler $error");
                  }
                  break;
                case 'Remove photo':
                  try {
                    context.read<EditProfileBloc>().setAvatar(Uint8List(0));
                  } catch (error) {
                    xLog.e("pickImagehandler $error");
                  }
                  break;
              }
            }));
  }

  Widget _renderInforUser() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.m16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            XPaddingUtils.verticalPadding(height: AppPadding.p23),
            _renderName(context),
            XPaddingUtils.verticalPadding(height: AppPadding.p16),
            _renderEmail(context),
            XPaddingUtils.verticalPadding(height: AppPadding.p16),
            _renderDateOfBirth(context),
            XPaddingUtils.verticalPadding(height: AppPadding.p16),
            _renderGender(),
            XPaddingUtils.verticalPadding(height: AppPadding.p16),
            _renderHeightAndWeight(context),
            XPaddingUtils.verticalPadding(height: AppPadding.p16),
          ],
        ),
      ),
    );
  }

  Widget _renderName(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (pre, cur) =>
          pre.name != cur.name ||
          pre.errorName != cur.errorName ||
          pre.initName != cur.initName,
      builder: (context, state) {
        return XTextFieldWithLabel(
          label: S.of(context).name,
          hintText: S.of(context).enterYourName,
          initText: state.initName,
          errorText: StringUtils.isNullOrEmpty(state.errorName)
              ? null
              : state.errorName,
          onChanged: (name) {
            context.read<EditProfileBloc>().onChangeName(name);
          },
        );
      },
    );
  }

  Widget _renderEmail(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (pre, cur) => pre.email != cur.email,
      builder: (context, state) {
        return XTextFieldWithLabel(
          label: S.of(context).email,
          hintText: S.of(context).enterYourEmail,
          initText: state.email,
          onChanged: (mail) {},
          isEnable: false,
        );
      },
    );
  }

  Widget _renderDateOfBirth(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (pre, cur) => pre.dateOfBirth != cur.dateOfBirth,
      builder: (context, state) {
        return XLabelButton(
          onTapped: () async {
            await context
                .read<EditProfileBloc>()
                .onTapDateOfBirthButton(context);
          },
          hint: S.of(context).selectDate,
          label: S.of(context).dateOfBirth,
          value: state.dateOfBirth?.toMMMdy,
          icon: Icons.calendar_today_outlined,
        );
      },
    );
  }

  Widget _renderGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).gender, style: AppTextStyle.labelStyle),
        XPaddingUtils.verticalPadding(height: AppPadding.p8),
        Container(
            decoration: BoxDecoration(
              color: AppColors.grey6,
              borderRadius: BorderRadius.circular(AppRadius.r10),
            ),
            child: _renderGenderRadio()),
      ],
    );
  }

  Widget _renderGenderRadio() {
    return BlocSelector<EditProfileBloc, EditProfileState, Gender?>(
      selector: (state) {
        return state.gender;
      },
      builder: (context, gender) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: XRadioListTile<Gender>(
                value: Gender.female,
                groupValue: gender ?? Gender.female,
                label: S.of(context).female,
                onChanged: (value) {
                  context.read<EditProfileBloc>().onChangeGender(value);
                },
              ),
            ),
            Container(
              width: AppSize.s1,
              height: AppSize.s20,
              color: AppColors.grey2,
            ),
            Expanded(
              child: XRadioListTile<Gender>(
                value: Gender.male,
                groupValue: gender ?? Gender.female,
                label: S.of(context).male,
                onChanged: (value) {
                  context.read<EditProfileBloc>().onChangeGender(value);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _renderHeightAndWeight(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(S.of(context).bodyMeasurement, style: AppTextStyle.labelStyle),
        XPaddingUtils.verticalPadding(height: AppPadding.p8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.grey5,
              width: AppSize.s1,
            ),
            borderRadius: BorderRadius.circular(
              AppRadius.r10,
            ),
          ),
          child: _renderSegmentControl(),
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p16),
        Column(
          children: [
            _renderHeight(context),
            XPaddingUtils.verticalPadding(height: AppPadding.p16),
            _renderWeight(context),
          ],
        ),
      ],
    );
  }

  Widget _renderSegmentControl() {
    return BlocSelector<EditProfileBloc, EditProfileState,
        MeasurementUnitType?>(
      selector: (state) {
        return state.measurementUnit;
      },
      builder: (context, measurementUnit) {
        return XUnitsSegment(
          unitType: measurementUnit ?? MeasurementUnitType.metric,
          onTap: (MeasurementUnitType? value) {
            context.read<EditProfileBloc>().onChangeMeasurementUnitType(value);
          },
        );
      },
    );
  }

  String _markerText(
      double currentValue, RulerType rulerType, MeasurementUnitType unitType) {
    switch (rulerType) {
      case RulerType.height:
        switch (unitType) {
          case MeasurementUnitType.imperial:
            return "${(currentValue).toFeet() ~/ 100} ft, ${((currentValue).toFeet() % 100).toInt()} in";
          case MeasurementUnitType.metric:
            return "${currentValue.round()} cm";
        }
      case RulerType.weight:
        switch (unitType) {
          case MeasurementUnitType.imperial:
            return "${(currentValue).toLb().toStringAsFixed(2)} lb";
          case MeasurementUnitType.metric:
            return "$currentValue kg";
        }
    }
  }

  Widget _renderHeight(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) =>
          previous.height != current.height ||
          previous.measurementUnit != current.measurementUnit,
      builder: (context, state) {
        return GestureDetector(
            onTap: () {
              _onTapHeightAndWeight(context,
                  rulerType: RulerType.height,
                  measurementUnitType:
                      state.measurementUnit ?? MeasurementUnitType.metric);
            },
            child: _renderTextFieldHeightWeight(
              _markerText(state.height ?? 0.0, RulerType.height,
                  state.measurementUnit ?? MeasurementUnitType.metric),
              S.of(context).height,
            ));
      },
    );
  }

  Widget _renderWeight(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) =>
          previous.weight != current.weight ||
          previous.measurementUnit != current.measurementUnit,
      builder: (context, state) {
        return GestureDetector(
            onTap: () {
              _onTapHeightAndWeight(context,
                  rulerType: RulerType.weight,
                  measurementUnitType:
                      state.measurementUnit ?? MeasurementUnitType.metric);
            },
            child: _renderTextFieldHeightWeight(
              _markerText(state.weight ?? 0.0, RulerType.weight,
                  state.measurementUnit ?? MeasurementUnitType.metric),
              S.of(context).weight,
            ));
      },
    );
  }

  void _onTapHeightAndWeight(
    BuildContext context, {
    required RulerType rulerType,
    required MeasurementUnitType measurementUnitType,
  }) {
    final state = context.read<EditProfileBloc>().state;
    double value = 0;
    if (rulerType == RulerType.weight) {
      value = (state.weight?.toLb() ?? 0.0) * 10;
    } else {
      value = state.height?.toFeet() ?? 0.0;
    }
    showCupertinoModalBottomSheet(
      duration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeOut,
      context: context,
      builder: (context) => XRulerBottomSheet(
        value: value,
        rulerType: rulerType,
        measurementUnitType: measurementUnitType,
      ),
      barrierColor: Colors.transparent.withOpacity(0.5),
      enableDrag: false,
    ).then((valueCallback) {
      if (valueCallback != null) {
        final value = valueCallback as int;
        if (rulerType == RulerType.weight) {
          measurementUnitType != MeasurementUnitType.metric
              ? context
                  .read<EditProfileBloc>()
                  .onChangeWeight(value.toDouble().toKilogram() / 10)
              : context
                  .read<EditProfileBloc>()
                  .onChangeWeight(value.toDouble() / 10);
        } else {
          measurementUnitType != MeasurementUnitType.metric
              ? context
                  .read<EditProfileBloc>()
                  .onChangeHeight(value.toDouble().toCentimeter())
              : context
                  .read<EditProfileBloc>()
                  .onChangeHeight(value.toDouble());
        }
      }
    });
  }

  Widget _renderTextFieldHeightWeight(String value, String title) {
    return TextFormField(
      style: AppTextStyle.labelStyle,
      decoration: InputDecoration(
        suffixIconConstraints: const BoxConstraints(
          maxWidth: AppSize.s150,
        ),
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              value,
              style: AppTextStyle.contentTexStyle,
            ),
            const IconButton(
              constraints: BoxConstraints(maxWidth: AppSize.s36),
              padding: EdgeInsets.fromLTRB(
                AppPadding.p10,
                AppPadding.p8,
                AppPadding.p12,
                AppPadding.p8,
              ),
              icon: Icon(Icons.keyboard_arrow_down_rounded),
              onPressed: null,
              splashColor: Colors.transparent,
            ),
          ],
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: AppSize.s36,
        ),
        prefixIcon: Container(
          padding: const EdgeInsets.only(left: AppPadding.p12),
          child: Text(title, style: AppTextStyle.labelStyle),
        ),
        enabled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.r10,
          ),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
