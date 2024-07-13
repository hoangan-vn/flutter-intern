import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/config/enum/language_enum.dart';
import 'package:safebump/src/feature/edit_profile/widget/unit_segment.dart';
import 'package:safebump/src/feature/setting/logic/setting_bloc.dart';
import 'package:safebump/src/feature/setting/logic/setting_state.dart';
import 'package:safebump/src/feature/setting/widget/language_options_bottom_sheet.dart';
import 'package:safebump/src/feature/setting/widget/unit_segment_with_title.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/services/user_prefs.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/widget/appbar/appbar_dashboard.dart';
import 'package:safebump/widget/card/card_item_with_icon.dart';
import 'package:safebump/widget/separator/solid_separator.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().inital();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: _renderBody(),
      ),
    );
  }

  Widget _renderBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _renderAppBar(),
              const SizedBox(height: AppSize.s24),
              _renderUnits(),
              _renderAccount()
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderAppBar() {
    return XAppBarDashboard(
      title: S.of(context).settings,
      leading: IconButton(
          onPressed: () {
            context.read<SettingsBloc>().saveSharedPref();
            AppCoordinator.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: AppSize.s20,
          )),
    );
  }

  Widget _renderBodyMeasurementUnit() {
    return BlocSelector<SettingsBloc, SettingsState, MeasurementUnitType>(
      selector: (state) {
        return state.measurementUnitType;
      },
      builder: (context, measurementUnitType) {
        return XUnitSegmentWithTitle(
            title: S.of(context).bodyMeasurement,
            unitType: measurementUnitType,
            metricText: S.of(context).kgCm,
            imperialText: S.of(context).lbFt,
            onTap: (type) => context
                .read<SettingsBloc>()
                .onChangedMeasurementUnit(type ?? MeasurementUnitType.metric));
      },
    );
  }

  Widget _renderUnits() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _renderIconWithTitle(Icons.av_timer_rounded, S.of(context).units),
        XPaddingUtils.verticalPadding(height: AppPadding.p16),
        _renderBodyMeasurementUnit(),
        XPaddingUtils.verticalPadding(height: AppPadding.p23),
      ],
    );
  }

  Widget _renderAccount() {
    return Column(
      children: [
        _renderIconWithTitle(
          Icons.person,
          S.of(context).account,
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p16),
        SizedBox(
          height: AppSize.s48,
          child: XCardItemWithIcon(
              text: S.of(context).language,
              iconPath: Icons.keyboard_arrow_right_rounded,
              paddingItem: const EdgeInsets.only(right: AppPadding.p6),
              onTap: () {
                _onTapShowLanguageOptions();
              }),
        ),
        SizedBox(
          height: AppSize.s48,
          child: XCardItemWithIcon(
              text: S.of(context).deleteAccount,
              iconPath: Icons.keyboard_arrow_right_rounded,
              paddingItem: const EdgeInsets.only(right: AppPadding.p6),
              onTap: () {
                context.read<SettingsBloc>().onTappedDeleteAccount(context);
              }),
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p23),
      ],
    );
  }

  void _onTapShowLanguageOptions() {
    showCupertinoModalBottomSheet(
      duration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeOut,
      context: context,
      builder: (context) => XOptionsBottomSheet(
        title: S.of(context).selectLanguage,
      ),
      barrierColor: Colors.transparent.withOpacity(0.5),
      enableDrag: false,
    ).then((valueCallback) {
      if (valueCallback != null) {
        UserPrefs.I.setLanguage(valueCallback as LanguageEnum);
      }
    });
  }

  Widget _renderIconWithTitle(IconData icon, String title) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p2,
                  right: AppPadding.p10,
                ),
                child: Icon(icon)),
            Text(
              title,
              style: const TextStyle(
                fontFamily: FontFamily.inter,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                fontSize: AppFontSize.f20,
              ),
            ),
          ],
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p16),
        const XSolidSeparator(),
      ],
    );
  }
}
