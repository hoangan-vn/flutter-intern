import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:safebump/src/feature/add_baby/logic/cubit/add_fetus_bloc.dart';
import 'package:safebump/src/feature/add_baby/logic/state/add_fetus_state.dart';
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
import 'package:safebump/widget/text_field/text_field_with_label.dart';

class AddPreggyScreen extends StatelessWidget {
  const AddPreggyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DismissKeyBoard(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                XPaddingUtils.verticalPadding(height: AppPadding.p59),
                _renderTitle(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p45),
                _renderAddImage(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p20),
                _renderNameField(context),
                XPaddingUtils.verticalPadding(height: AppPadding.p20),
                _renderDueDate(context),
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
          S.of(context).happyPreggy,
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
      child: BlocBuilder<AddFetusBloc, AddFetusState>(
        buildWhen: (previous, current) =>
            previous.errorFetusName != current.errorFetusName,
        builder: (context, state) {
          return XTextFieldWithLabel(
              labelStyle: AppTextStyle.labelStyle,
              hintStyle: AppTextStyle.hintTextStyle,
              errorText: StringUtils.isNullOrEmpty(state.errorFetusName)
                  ? null
                  : state.errorFetusName,
              hintText: S.of(context).babysName,
              label: S.of(context).name,
              onChanged: (text) {
                context.read<AddFetusBloc>().onChangedFetusName(text);
              });
        },
      ),
    );
  }

  Widget _renderDueDate(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: BlocBuilder<AddFetusBloc, AddFetusState>(
        buildWhen: (previous, current) =>
            previous.fetusDueDate != current.fetusDueDate ||
            previous.errorFetusDueDate != current.errorFetusDueDate,
        builder: (context, state) {
          return XLabelButton(
            onTapped: () async {
              _showDateTimeBottomSheet(context,
                  fetusDueDate: state.fetusDueDate);
            },
            hint: S.of(context).addDueDate,
            value: isNullOrEmpty(state.fetusDueDate)
                ? null
                : state.fetusDueDate!.toMMMdy,
            labelStyle: AppTextStyle.labelStyle,
            hintStyle: AppTextStyle.hintTextStyle,
            label: S.of(context).dueDate,
            icon: Icons.calendar_today_outlined,
          );
        },
      ),
    ));
  }

  Future<void> _showDateTimeBottomSheet(BuildContext context,
      {DateTime? fetusDueDate}) async {
    await showBoardDateTimePicker(
      context: context,
      pickerType: DateTimePickerType.date,
      initialDate: fetusDueDate,
      minimumDate: DateTime.now().subtract(const Duration(days: 280)),
      maximumDate: DateTime.now().add(const Duration(days: 280)),
      options: BoardDateTimeOptions(
        boardTitle: S.of(context).selectDate,
        activeColor: AppColors.primary,
        showDateButton: false,
      ),
    ).then((value) => context
        .read<AddFetusBloc>()
        .onChangedFetusDueDate(value ?? DateTime.now()));
  }

  Widget _renderBottomButton(BuildContext context) {
    return BlocSelector<AddFetusBloc, AddFetusState, AddFetusScreenStatus>(
      selector: (state) {
        return state.status;
      },
      builder: (context, status) {
        return XBottomButtons(
            positiveButtonText: S.of(context).save,
            cancelButtonText: S.of(context).cancel,
            isLoading: status == AddFetusScreenStatus.saving,
            onTappedPositive: () {
              context.read<AddFetusBloc>().saveFetusInfor();
            },
            onTappedCancel: () {
              AppCoordinator.pop();
            });
      },
    );
  }
}
