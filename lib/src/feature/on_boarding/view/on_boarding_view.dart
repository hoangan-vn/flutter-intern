import 'package:flutter/material.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/config/constant/app_constant.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/model/on_boarding_model.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/widget/button/fill_button.dart';
import 'package:safebump/widget/page/title_and_content_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late PageController _controller;
  late List<OnBoardingModel> _listOnBoardingData;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _listOnBoardingData = AppConstant.getListDataOfOnBoarding(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: _renderPageView()),
        _renderFooter(),
        XPaddingUtils.verticalPadding(height: AppPadding.p12)
      ],
    ));
  }

  Widget _renderPageView() {
    return PageView.builder(
      controller: _controller,
      itemCount: _listOnBoardingData.length,
      itemBuilder: (context, index) => XTitleAndContentPage(
        firstTitle: _listOnBoardingData[index].fistTitle,
        secondTitle: _listOnBoardingData[index].secondTitle,
        firstStyle: const TextStyle(
            color: AppColors.black,
            fontFamily: FontFamily.productSans,
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.f30),
        secondStyle: const TextStyle(
            color: AppColors.primary,
            fontFamily: FontFamily.productSans,
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.f30),
        hasImage: true,
        image: _listOnBoardingData[index].image,
        content: _renderPageContent(index),
      ),
    );
  }

  Widget _renderPageContent(int pageNumber) {
    switch (pageNumber) {
      case 0:
        return _renderFirstPageContent();
      case 4:
        return _renderLastPageContent();
      default:
        return _renderOtherPageContent(pageNumber);
    }
  }

  Widget _renderFirstPageContent() {
    return Column(
      children: [
        Text(
          S.of(context).welcome,
          style: const TextStyle(
              fontSize: AppFontSize.f20,
              fontFamily: FontFamily.productSans,
              fontWeight: FontWeight.bold),
        ),
        XPaddingUtils.verticalPadding(height: AppPadding.p15),
        Text(
          _listOnBoardingData[0].content,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: AppFontSize.f14, fontFamily: FontFamily.productSans),
        )
      ],
    );
  }

  Widget _renderLastPageContent() {
    return Column(
      children: [
        Text(
          _listOnBoardingData[_listOnBoardingData.length - 1].content,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: AppFontSize.f14),
        ),
        _renderGetStartedButton(),
      ],
    );
  }

  Widget _renderGetStartedButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p45),
        child: XFillButton(
            onPressed: () => AppCoordinator.showSignInScreen(),
            label: Text(
              S.of(context).getStarted,
              style: const TextStyle(
                  color: AppColors.white,
                  fontSize: AppFontSize.f16,
                  fontFamily: FontFamily.abel,
                  fontWeight: FontWeight.bold),
            )));
  }

  Widget _renderOtherPageContent(int pageNumber) {
    return Text(
      _listOnBoardingData[pageNumber].content,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: AppFontSize.f14, fontFamily: FontFamily.productSans),
    );
  }

  Widget _renderFooter() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _renderSkipButton(),
        _renderIndicator(),
        _renderNextButton(),
      ],
    );
  }

  Widget _renderSkipButton() {
    return TextButton(
        onPressed: () => AppCoordinator.showSignInScreen(),
        child: Text(
          S.of(context).skip.toUpperCase(),
          style: const TextStyle(
              fontSize: AppFontSize.f16,
              color: AppColors.black,
              fontFamily: FontFamily.productSans),
        ));
  }

  Widget _renderIndicator() {
    return SmoothPageIndicator(
      controller: _controller,
      count: 5,
      effect: const ScrollingDotsEffect(
          activeStrokeWidth: AppSize.s20,
          activeDotScale: AppSize.s2,
          maxVisibleDots: 5,
          radius: 8,
          spacing: AppPadding.p8,
          dotHeight: AppSize.s6,
          dotWidth: AppSize.s6,
          activeDotColor: AppColors.primary),
    );
  }

  Widget _renderNextButton() {
    return TextButton(
        onPressed: () {
          _controller.animateToPage((_controller.page! + 1).toInt(),
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear);
        },
        child: Text(
          S.of(context).next.toUpperCase(),
          style: const TextStyle(
              fontSize: AppFontSize.f16,
              color: AppColors.black,
              fontFamily: FontFamily.productSans),
        ));
  }
}
