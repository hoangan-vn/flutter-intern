import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/src/feature/medicine/logic/add_medication_bloc.dart';
import 'package:safebump/src/feature/medicine/logic/add_medication_state.dart';
import 'package:safebump/src/feature/medicine/widget/medication_detail_bottom_sheet.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/widget/text_field/text_field_with_label.dart';

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({Key? key}) : super(key: key);

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen>
    with TickerProviderStateMixin {
  AnimationController? controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.black,
              size: AppSize.s20,
            ),
            onPressed: () {
              AppCoordinator.pop();
            },
          ),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s4),
                topRight: Radius.circular(AppSize.s4),
              ),
            ),
            child: Column(
              children: [
                _renderHeader(context),
                _renderBlueLine(),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).whatMedicationWillYouTake,
                          style: AppTextStyle.labelStyle,
                        ),
                        _renderSearchInput(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _renderHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p12,
      ),
      child: Text(
        S.of(context).addAMedication,
        style: AppTextStyle.titleTextStyle,
      ),
    );
  }

  Container _renderBlueLine() {
    return Container(
      margin: const EdgeInsets.only(top: AppMargin.m8),
      height: AppSize.s6,
      color: AppColors.green,
    );
  }

  Container _renderSearchInput() {
    return Container(
        margin: const EdgeInsets.only(
          top: AppMargin.m24,
          bottom: AppMargin.m8,
        ),
        child: BlocBuilder<AddMedicationBloc, AddMedicationState>(
          buildWhen: (previous, current) =>
              previous.name != current.name ||
              previous.nameError != current.nameError,
          builder: (context, state) {
            return XTextFieldWithLabel(
              hintText: S.of(context).enterMedicationName,
              onChanged: (text) {
                context.read<AddMedicationBloc>().onChangedMedicationName(text);
              },
              errorText: StringUtils.isNullOrEmpty(state.nameError)
                  ? null
                  : state.nameError,
              prefix: const Icon(
                Icons.medication_outlined,
                color: AppColors.hintTextColor,
                size: AppSize.s20,
              ),
              suffix: IconButton(
                icon: const Icon(
                  Icons.rocket_launch,
                  color: AppColors.hintTextColor,
                  size: AppSize.s20,
                ),
                onPressed: () {
                  if (context
                      .read<AddMedicationBloc>()
                      .isNameInvalid(context)) {
                    return;
                  }
                  _showMedicationDetailBottomsheet(context);
                },
              ),
            );
          },
        ));
  }

  Future<void> _showMedicationDetailBottomsheet(BuildContext context) async {
    await showModalBottomSheet(
      transitionAnimationController: controller,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.92,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocProvider.value(
              value: BlocProvider.of<AddMedicationBloc>(context),
              child: const XMedicationDetailBottomSheet(
                isEdit: false,
              ),
            )),
      ),
      isScrollControlled: true,
      barrierColor: AppColors.black.withOpacity(0.6),
      enableDrag: true,
      isDismissible: true,
    ).then((value) {
      if (value == true) {
        AppCoordinator.pop(true);
      }
    });
  }
}
