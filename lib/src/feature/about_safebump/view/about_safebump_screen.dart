import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/config/constant/links.dart';
import 'package:safebump/src/config/device/app_info.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/decorations.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/widget/appbar/appbar_dashboard.dart';
import 'package:safebump/widget/card/card_item_with_icon.dart';
import 'package:safebump/widget/separator/solid_separator.dart';
import 'package:safebump/widget/webview/web_view.dart';

class AboutSafeBumpScreen extends StatefulWidget {
  const AboutSafeBumpScreen({Key? key}) : super(key: key);

  @override
  State<AboutSafeBumpScreen> createState() => _AboutSafeBumpScreenState();
}

class _AboutSafeBumpScreenState extends State<AboutSafeBumpScreen> {
  static List<String> getData(BuildContext context) => [
        S.of(context).privacyPolicy,
        S.of(context).termsAndConditions,
        S.of(context).rateSafeBump,
      ];

  var version = '';
  late List<String> data;

  @override
  void initState() {
    _getVersion();
    super.initState();
  }

  void _getVersion() async {
    final package = AppInfo.package;
    final versionApp = package.version;
    setState(() {
      version = versionApp;
    });
  }

  void onPressItem(int index, BuildContext context) {
    switch (index) {
      case 0:
        showCupertinoModalBottomSheet(
          duration: const Duration(milliseconds: 350),
          animationCurve: Curves.easeOut,
          backgroundColor: AppColors.white,
          context: context,
          builder: (context) => WebviewPage(
            title: S.of(context).privacyPolicy,
            url: XLink.policy,
          ),
          bounce: false,
        );
        break;
      case 1:
        showCupertinoModalBottomSheet(
          duration: const Duration(milliseconds: 350),
          animationCurve: Curves.easeOut,
          backgroundColor: AppColors.white,
          context: context,
          builder: (context) => WebviewPage(
            title: S.of(context).termsAndConditions,
            url: XLink.termsAndConditions,
          ),
          bounce: false,
        );
        break;
      case 2:
        break;
      default:
    }
  }

  Widget _renderCell(int i, BuildContext context) {
    return XCardItemWithIcon(
      text: data[i],
      firstItem: i == 0,
      lastItem: i == data.length - 1,
      iconPath: Icons.keyboard_arrow_right_rounded,
      onTap: () => onPressItem(i, context),
    );
  }

  @override
  Widget build(BuildContext context) {
    data = getData(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppPadding.p16),
        color: AppColors.white3,
        child: Column(
          children: [
            _renderAppBar(context),
            _renderHeader(),
            _renderOptions(context),
          ],
        ),
      ),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBarDashboard(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          AppCoordinator.pop();
        },
      ),
      title: S.of(context).aboutSafeBump,
    );
  }

  Widget _renderHeader() {
    return Column(
      children: [
        Assets.images.images.logo.image(width: AppSize.s200),
        XPaddingUtils.verticalPadding(height: AppPadding.p12),
        Text(
          'Version $version',
          style: const TextStyle(
            fontFamily: FontFamily.abel,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
            fontSize: AppFontSize.f14,
          ),
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p16),
      ],
    );
  }

  Widget _renderOptions(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: AppDecorations.shadow,
        borderRadius: BorderRadius.circular(AppRadius.r8),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.r8),
          side: const BorderSide(color: AppColors.grey5),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => _renderCell(index, context),
          itemCount: data.length,
          separatorBuilder: (context, index) {
            return const XSolidSeparator(
              color: AppColors.grey6,
            );
          },
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
