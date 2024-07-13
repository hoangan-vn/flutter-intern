import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:safebump/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:safebump/src/config/constant/app_constant.dart';
import 'package:safebump/src/config/enum/medication_enum.dart';
import 'package:safebump/src/feature/medicine/logic/add_medication_bloc.dart';
import 'package:safebump/src/feature/medicine/logic/add_medication_state.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/model/medications/medication.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/src/utils/utils.dart';
import 'package:safebump/widget/chip/warning_chip.dart';
import 'package:safebump/widget/list_view/list_view_bottom_sheet.dart';
import 'package:safebump/widget/separator/solid_separator.dart';
import 'package:safebump/widget/text_field/adjust_value_input.dart';
import 'package:safebump/widget/text_field/pickable_text_field.dart';
import 'package:safebump/widget/text_field/text_field_with_label.dart';

class XMedicationDetailBottomSheet extends StatefulWidget {
  const XMedicationDetailBottomSheet(
      {Key? key, required this.isEdit, this.medication})
      : super(key: key);
  final bool isEdit;
  final MMedication? medication;

  @override
  State<XMedicationDetailBottomSheet> createState() =>
      _XMedicationDetailBottomSheetState();
}

class _XMedicationDetailBottomSheetState
    extends State<XMedicationDetailBottomSheet> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    if (widget.isEdit && !isNullOrEmpty(widget.medication)) {
      context.read<AddMedicationBloc>().initialize(widget.medication!);
    }
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyBoard(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppRadius.r30),
          topRight: Radius.circular(AppRadius.r30),
        ),
        child: Container(
          color: AppColors.white3,
          child: Column(
            children: [
              _renderAppBar(context),
              _renderBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => AppCoordinator.pop(),
          icon: const Icon(
            Icons.clear,
            size: AppSize.s20,
          ),
          splashRadius: 1,
        ),
        BlocSelector<AddMedicationBloc, AddMedicationState,
            AddMedicationStatus>(
          selector: (state) {
            return state.status;
          },
          builder: (context, resultState) {
            if (resultState == AddMedicationStatus.loading) {
              return const Padding(
                padding: EdgeInsets.all(AppPadding.p16),
                child: SizedBox(
                  height: AppSize.s16,
                  width: AppSize.s16,
                  child: CircularProgressIndicator(
                    color: AppColors.green,
                    strokeWidth: AppSize.s2,
                  ),
                ),
              );
            }
            return IconButton(
              onPressed: () {
                context
                    .read<AddMedicationBloc>()
                    .onPressSaveButton(context, widget.medication?.id);
              },
              icon: const Icon(
                Icons.check,
                size: AppSize.s20,
                color: AppColors.green,
              ),
              splashRadius: 1,
            );
          },
        ),
      ],
    );
  }

  Widget _renderBody() {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: AppColors.white3,
              padding: const EdgeInsets.only(
                left: AppPadding.p16,
                right: AppPadding.p16,
                top: AppPadding.p16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _renderMedicineName(),
                  XPaddingUtils.verticalPadding(height: AppPadding.p16),
                  _renderAmountAndUnit(),
                  XPaddingUtils.verticalPadding(height: AppPadding.p23),
                  _renderNotesSection(),
                  XPaddingUtils.verticalPadding(height: AppPadding.p16),
                  _renderFrequencyAndReminder(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderMedicineName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).medicationName,
          style: AppTextStyle.labelStyle,
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p8),
        Text(
          context.read<AddMedicationBloc>().state.name,
          style: AppTextStyle.labelStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.f20,
              color: AppColors.primary),
        ),
      ],
    );
  }

  Widget _renderAmountAndUnit() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: XAdjustValueInput(
            title: S.of(context).dose,
            amount: context.read<AddMedicationBloc>().state.amount,
            onValueChange: ((value) =>
                context.read<AddMedicationBloc>().setAmount(value)),
          ),
        ),
        XPaddingUtils.horizontalPadding(width: AppPadding.p16),
        BlocSelector<AddMedicationBloc, AddMedicationState, DoseType?>(
          selector: (state) {
            return state.doseType;
          },
          builder: (context, unit) {
            return Flexible(
              child: XPickableTextField(
                key: UniqueKey(),
                isBoldLabel: false,
                hint: '',
                textValue: unit?.getText(),
                contentPadding: const EdgeInsets.all(AppPadding.p14),
                isEditable: false,
                trailingIcon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: AppSize.s24,
                ),
                onPressTextField: () {
                  _renderUnitsBottomSheet();
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _renderNotesSection() {
    return Column(
      children: [
        BlocBuilder<AddMedicationBloc, AddMedicationState>(
          buildWhen: (pre, cur) =>
              pre.name != cur.name ||
              pre.nameError != cur.nameError ||
              pre.nameInit != cur.nameInit,
          builder: (context, state) {
            return XTextFieldWithLabel(
              initText: state.nameInit,
              label: S.of(context).notes,
              onChanged: (value) {
                context.read<AddMedicationBloc>().setNotes(value);
              },
              hintText: S.of(context).addYourNotesHere,
              maxLines: 3,
              textInputAction: TextInputAction.newline,
            );
          },
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p30),
        const XSolidSeparator(
          color: AppColors.grey5,
        ),
      ],
    );
  }

  Widget _renderFrequencyAndReminder() {
    return BlocBuilder<AddMedicationBloc, AddMedicationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderFrequencySection(state),
            XPaddingUtils.verticalPadding(height: AppPadding.p16),
            _renderTakeTimeList(state),
            XPaddingUtils.verticalPadding(height: AppPadding.p16),
            _renderEmptyTime(state),
            XPaddingUtils.verticalPadding(height: AppPadding.p16),
          ],
        );
      },
    );
  }

  Widget _renderFrequencySection(AddMedicationState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            state.frequency.getValue,
            style:
                AppTextStyle.titleTextStyle.copyWith(fontSize: AppFontSize.f16),
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<AddMedicationBloc>().showBottomSheetDateTimePicker(
                context,
                title: S.of(context).selectTime,
                type: DateTimePickerType.time, onChanged: (time) {
              context.read<AddMedicationBloc>().onChangedListRemindTime(time);
            });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r8),
                border: Border.all(color: AppColors.primary)),
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p6, vertical: AppPadding.p2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(S.of(context).addATime,
                    style: AppTextStyle.labelStyle
                        .copyWith(color: AppColors.primary)),
                XPaddingUtils.horizontalPadding(width: AppPadding.p6),
                const Icon(
                  Icons.timer,
                  size: AppSize.s16,
                  color: AppColors.primary,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _renderTakeTimeList(AddMedicationState state) {
    return isNullOrEmpty(state.time)
        ? const SizedBox.shrink()
        : Wrap(
            spacing: AppMargin.m8,
            runSpacing: AppMargin.m8,
            children: state.time!
                .map(
                  (element) => XWarningChip(
                    title: element,
                    icon: _getTimerIcon(element),
                    removeRemindTime: (time) => context
                        .read<AddMedicationBloc>()
                        .removeRemindTime(time),
                  ),
                )
                .toList(),
          );
  }

  IconData _getTimerIcon(String time) {
    final hour = int.parse(time.split(':').first);
    if (hour >= 6 && hour < 12) return Icons.wb_sunny_outlined;
    if (hour >= 12 && hour < 20) return Icons.wb_twilight_outlined;
    return Icons.nights_stay_outlined;
  }

  void _renderUnitsBottomSheet() {
    final unitEnumList = [...AppConstant.medicationUnitList];
    final unitStringList = unitEnumList.map((e) => e.getText()).toList();
    unitStringList.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
    showCupertinoModalBottomSheet(
      duration: const Duration(milliseconds: 350),
      animationCurve: Curves.easeOut,
      context: context,
      builder: (_) => XListViewBottomSheet(
        title: S.of(context).selectAForm,
        data: unitStringList,
        buttonName: S.of(context).done,
        heightFactor: 0.3,
        selectedValue:
            context.read<AddMedicationBloc>().state.doseType.getText(),
        onPressDone: (value) {
          context.read<AddMedicationBloc>().setDoseType(value);
        },
      ),
      enableDrag: false,
    );
  }

  Widget _renderEmptyTime(AddMedicationState state) {
    return StringUtils.isNullOrEmpty(state.timeError)
        ? const SizedBox.shrink()
        : Text(
            state.timeError!,
            style: AppTextStyle.labelStyle.copyWith(color: AppColors.red),
          );
  }
}
