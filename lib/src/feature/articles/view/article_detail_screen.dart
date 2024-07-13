import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/articles/logic/article_detail_bloc.dart';
import 'package:safebump/src/feature/articles/logic/article_detail_state.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/model/articles/articles.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/decorations.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/utils.dart';
import 'package:safebump/widget/button/fill_button.dart';
import 'package:safebump/widget/webview/web_view.dart';

class ArticlesDetailScreen extends StatefulWidget {
  const ArticlesDetailScreen({super.key});

  @override
  State<ArticlesDetailScreen> createState() => _ArticlesDetailScreenState();
}

class _ArticlesDetailScreenState extends State<ArticlesDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ArticleDetailBloc>().inital(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          switch (state.status) {
            case ArticleDetailStatus.fail:
              XToast.error(S.of(context).tryAgain);
              return _renderFailFetchArticle();
            case ArticleDetailStatus.success:
              return _renderArticle();
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _renderArticle() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          flexibleSpace: FlexibleSpaceBar(
            background: _renderArticleImage(),
            stretchModes: const [StretchMode.zoomBackground],
          ),
          pinned: true,
          expandedHeight: 200,
          stretch: true,
          elevation: 0,
          centerTitle: true,
        ),
        SliverList.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 500,
                  maxHeight: 1000,
                ),
                child: Container(
                  constraints: const BoxConstraints.tightFor(),
                  padding: const EdgeInsets.all(AppPadding.p15),
                  // hard set height
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppRadius.r10),
                        topRight: Radius.circular(AppRadius.r10)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _renderTitleArticle(),
                      XPaddingUtils.verticalPadding(height: AppPadding.p20),
                      _renderContentArticle(),
                      _renderReadMoreButton(),
                      XPaddingUtils.verticalPadding(height: AppPadding.p20),
                      _renderRelatedArticlesText(),
                      XPaddingUtils.verticalPadding(height: AppPadding.p10),
                      _renderRelatedArticles(),
                    ],
                  ),
                ),
              );
            })
        // SliverFillRemaining(
        //   child:
        // ),
      ],
    );
  }

  Widget _renderArticleImage() {
    return BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
        builder: (context, state) => isNullOrEmpty(state.image)
            ? const SizedBox.shrink()
            : Image.memory(
                state.image!,
                fit: BoxFit.cover,
              ));
  }

  Widget _renderTitleArticle() {
    return BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
      buildWhen: (previous, current) => previous.article != current.article,
      builder: (context, state) {
        return Text(
          state.article?.title ?? '',
          style: AppTextStyle.titleTextStyle.copyWith(
            color: AppColors.primary,
          ),
        );
      },
    );
  }

  Widget _renderContentArticle() {
    return BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
      buildWhen: (previous, current) => previous.article != current.article,
      builder: (context, state) {
        return Stack(
          children: [
            Text(
              state.article?.content ?? '',
              style: const TextStyle(
                color: AppColors.black,
                fontSize: AppFontSize.f16,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: AppSize.s60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.white2.withOpacity(0),
                      AppColors.white3,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _renderFailFetchArticle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
              onPressed: () => AppCoordinator.pop(),
              label: Text(
                S.of(context).back,
                style: AppTextStyle.buttonTextStylePrimary,
              )),
          XPaddingUtils.verticalPadding(height: AppPadding.p45),
        ],
      ),
    );
  }

  Widget _renderReadMoreButton() {
    return BlocSelector<ArticleDetailBloc, ArticleDetailState, MArticles?>(
      selector: (state) {
        return state.article;
      },
      builder: (context, article) {
        return XFillButton(
            onPressed: () {
              if (isNullOrEmpty(article)) return;
              showCupertinoModalBottomSheet(
                duration: const Duration(milliseconds: 350),
                animationCurve: Curves.easeOut,
                backgroundColor: AppColors.white,
                context: context,
                builder: (context) => WebviewPage(
                  title: article!.title,
                  url: article.link,
                ),
                bounce: false,
              );
            },
            label: Text(
              S.of(context).readFull,
              style: AppTextStyle.buttonTextStylePrimary,
            ));
      },
    );
  }

  Widget _renderRelatedArticles() {
    return SizedBox(
      height: AppSize.s300,
      child: BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
        buildWhen: (previous, current) =>
            previous.listRelateArticle != current.listRelateArticle,
        builder: (context, state) {
          if (isNullOrEmpty(state.listRelateArticle) ||
              isNullOrEmpty(state.listRelateArticle)) {
            return const SizedBox.shrink();
          }
          return ListView.builder(
              itemCount: state.listRelateArticle!.length,
              itemExtent: AppSize.s250,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final article = state.listRelateArticle![index];
                final img = state.listRelateImage![article.id];
                return _renderArticleCard(context,
                    mArticles: article, image: img);
              });
        },
      ),
    );
  }

  Widget _renderArticleCard(BuildContext context,
      {required MArticles mArticles, Uint8List? image}) {
    return GestureDetector(
      onTap: () {
        AppCoordinator.pop();
        AppCoordinator.showArticleDetailScreen(mArticles.id);
      },
      child: Container(
        height: 400,
        margin: const EdgeInsets.symmetric(
            vertical: AppMargin.m10, horizontal: AppMargin.m16),
        padding: const EdgeInsets.all(AppPadding.p15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r10),
            color: AppColors.white,
            boxShadow: AppDecorations.shadow),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderImage(image),
            XPaddingUtils.verticalPadding(height: AppPadding.p15),
            _renderTitle(mArticles.title),
            XPaddingUtils.verticalPadding(height: AppPadding.p10),
            _renderAuthor(mArticles.author),
          ],
        ),
      ),
    );
  }

  Widget _renderImage(Uint8List? image) {
    return image == null
        ? const SizedBox.shrink()
        : Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r8),
            ),
            child: Image.memory(
              image,
              fit: BoxFit.cover,
            ),
          );
  }

  Widget _renderTitle(String title) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.titleTextStyle,
          ),
        ),
      ],
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

  Widget _renderRelatedArticlesText() {
    return Text(
      S.of(context).relatedArticles,
      style: AppTextStyle.titleTextStyle,
    );
  }
}
