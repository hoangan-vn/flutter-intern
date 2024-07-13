import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/src/feature/medicine/logic/add_medication_bloc.dart';
import 'package:safebump/src/feature/medicine/logic/medication_bloc.dart';
import 'package:safebump/src/feature/medicine/logic/medication_state.dart';
import 'package:safebump/src/feature/medicine/widget/medication_card.dart';
import 'package:safebump/src/feature/medicine/widget/medication_detail_bottom_sheet.dart';
import 'package:safebump/src/feature/medicine/widget/set_up_medication_screen.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/model/medications/medication.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/widget/appbar/appbar_dashboard.dart';
import 'package:safebump/widget/button/fill_button.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen>
    with SingleTickerProviderStateMixin {
  var inited = false;

  @override
  void initState() {
    super.initState();
    context.read<MedicationBloc>().inital();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white3,
        body: SafeArea(
          child: Column(
            children: [
              _renderAppBar(context),
              BlocBuilder<MedicationBloc, MedicationState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status ||
                    previous.listMedication != current.listMedication,
                builder: (context, state) {
                  switch (state.status) {
                    case MedicationScreenStatus.fail:
                      return _renderFailFetchQuestion();
                    case MedicationScreenStatus.success:
                      return state.listMedication.isEmpty
                          ? Expanded(
                              child: SetupMedicationScreen(
                              setupMedication: (isSuccess) => context
                                  .read<MedicationBloc>()
                                  .reloadPage(context, isSuccess),
                            ))
                          : _renderMedicationContent();
                    default:
                      return const SizedBox.shrink();
                  }
                },
              )
            ],
          ),
        ));
  }

  Widget _renderFailFetchQuestion() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.svg.emptyIllustratiom
              .svg(width: MediaQuery.of(context).size.width),
          Text(
            S.of(context).someThingWentWrong,
            style: AppTextStyle.labelStyle,
          ),
          XPaddingUtils.verticalPadding(height: AppPadding.p16),
          XFillButton(
              onPressed: () => context.read<MedicationBloc>().inital(),
              label: Text(
                S.of(context).tryAgain,
                style: AppTextStyle.buttonTextStylePrimary,
              )),
          XPaddingUtils.verticalPadding(height: AppPadding.p45),
        ],
      ),
    );
  }

  Widget _renderMedicationContent() {
    return Expanded(
      child: Column(
        children: [
          _renderHeaderMedication(),
          const SizedBox(height: AppSize.s10),
          _renderMedicationView(),
        ],
      ),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBarDashboard(
      title: S.of(context).medication,
      leading: IconButton(
        onPressed: () {
          AppCoordinator.pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _renderMedicationView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: _renderMedicationList(context),
      ),
    );
  }

  Widget _renderMedicationList(BuildContext context) {
    return BlocBuilder<MedicationBloc, MedicationState>(
      buildWhen: (previous, current) =>
          previous.listMedication != current.listMedication,
      builder: (context, state) {
        return ListView.builder(
            itemCount: state.listMedication.length,
            itemBuilder: (context, index) => XMedicationCard(
                medicationName: state.listMedication[index].name,
                medicationUnit:
                    '${state.listMedication[index].amount} ${state.listMedication[index].doseType.getText()}',
                onEditMedication: () => _showMedicationDetailBottomsheet(
                      context,
                      state.listMedication[index].copyWith(),
                    ),
                onDeleteMedication: () {
                  context
                      .read<MedicationBloc>()
                      .deleteMedication(context, state.listMedication[index]);
                }));
      },
    );
  }

  Widget _renderHeaderMedication() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).medication,
            style: AppTextStyle.titleTextStyle,
          ),
          IconButton(
              splashColor: AppColors.subPrimary,
              highlightColor: AppColors.subPrimary,
              onPressed: () async {
                await AppCoordinator.showAddMedication().then((value) {
                  if (value == true) {
                    context.read<MedicationBloc>().reloadPage(context, value);
                  }
                });
              },
              icon: const Icon(
                Icons.add_circle,
                color: AppColors.primary,
              )),
        ],
      ),
    );
  }

  Future<void> _showMedicationDetailBottomsheet(
      BuildContext context, MMedication medication) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.92,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocProvider(
              create: (context) => AddMedicationBloc(),
              child: XMedicationDetailBottomSheet(
                  isEdit: true, medication: medication),
            )),
      ),
      isScrollControlled: true,
      barrierColor: AppColors.black.withOpacity(0.6),
      enableDrag: true,
      isDismissible: true,
    ).then((value) {
      context.read<MedicationBloc>().reloadPage(context, true);
    });
  }
}
