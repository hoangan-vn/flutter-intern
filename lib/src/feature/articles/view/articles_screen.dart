import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/src/feature/articles/logic/articles_bloc.dart';
import 'package:safebump/src/feature/articles/logic/articles_state.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/model/articles/articles.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/decorations.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/utils.dart';
import 'package:safebump/widget/appbar/appbar_dashboard.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ArticlesBloc>().inital(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white3,
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _renderAppBar(context),
          _renderListArticles(context),
        ],
      )),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBarDashboard(
      title: S.of(context).articles,
      leading: IconButton(
        onPressed: () {
          AppCoordinator.pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      action: IconButton(
        icon: const Icon(Icons.search),
        onPressed: () => AppCoordinator.showArticlesSearchScreen(),
      ),
    );
  }

  Widget _renderListArticles(BuildContext context) {
    return Expanded(
        child: BlocBuilder<ArticlesBloc, ArticlesState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.articles != current.articles ||
          previous.listImage != current.listImage,
      builder: (context, state) {
        return isNullOrEmpty(state.articles) || isNullOrEmpty(state.listImage)
            ? const SizedBox.shrink()
            : ListView.builder(
                itemCount: state.articles!.length,
                itemBuilder: (context, index) => _renderArticleCard(
                    context,
                    state.articles![index],
                    state.listImage![state.articles![index].id]));
      },
    ));
  }

  Widget _renderArticleCard(
      BuildContext context, MArticles mArticles, Uint8List? image) {
    return GestureDetector(
      onTap: () => AppCoordinator.showArticleDetailScreen(mArticles.id),
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: AppMargin.m10, horizontal: AppMargin.m16),
        padding: const EdgeInsets.all(AppPadding.p15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r10),
            color: AppColors.white,
            boxShadow: AppDecorations.shadow),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderImage(image),
            XPaddingUtils.verticalPadding(height: AppPadding.p15),
            _renderTitle(mArticles.title),
            XPaddingUtils.verticalPadding(height: AppPadding.p10),
            _renderSummary(mArticles.summarize),
            XPaddingUtils.verticalPadding(height: AppPadding.p10),
            _renderAuthor(mArticles.author),
          ],
        ),
      ),
    );
  }

  Widget _renderImage(Uint8List? image) {
    return image == null ? const SizedBox.shrink() : Image.memory(image);
  }

  Widget _renderTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.titleTextStyle,
    );
  }

  Widget _renderSummary(String summarize) {
    return Text(
      summarize,
      style: const TextStyle(
        fontFamily: FontFamily.abel,
        fontWeight: FontWeight.bold,
        color: AppColors.hintTextColor,
      ),
    );
  }

  Widget _renderAuthor(String author) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Assets.svg.writer.svg(width: AppSize.s20),
        XPaddingUtils.horizontalPadding(width: AppPadding.p6),
        Text(
          S.of(context).by,
          style: AppTextStyle.hintTextStyle.copyWith(color: AppColors.black),
        ),
        XPaddingUtils.horizontalPadding(width: AppPadding.p2),
        Text(
          author,
          style: AppTextStyle.contentTexStyleBold
              .copyWith(color: AppColors.primary, fontSize: AppFontSize.f13),
        )
      ],
    );
  }
}
