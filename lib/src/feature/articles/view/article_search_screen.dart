import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/gen/assets.gen.dart';
import 'package:safebump/gen/fonts.gen.dart';
import 'package:safebump/package/dismiss_keyboard/dismiss_keyboard.dart';
import 'package:safebump/src/feature/articles/logic/article_search_bloc.dart';
import 'package:safebump/src/feature/articles/logic/article_search_state.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/model/articles/articles.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/decorations.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/debounce.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/utils.dart';
import 'package:safebump/widget/appbar/appbar_dashboard.dart';
import 'package:safebump/widget/chip/warning_chip.dart';
import 'package:safebump/widget/text_field/text_field_with_label.dart';

class ArticleSearchScreen extends StatefulWidget {
  const ArticleSearchScreen({Key? key}) : super(key: key);

  @override
  State<ArticleSearchScreen> createState() => _ArticleSearchScreenState();
}

class _ArticleSearchScreenState extends State<ArticleSearchScreen> {
  final XDebounce _debounce = XDebounce(const Duration(milliseconds: 500));
  late String searchTypeTitle;

  @override
  void initState() {
    super.initState();
    context.read<ArticlesSearchBloc>().inital(context);
  }

  @override
  void dispose() {
    _debounce.dispose();
    super.dispose();
  }

  void _onChangeText(String value) {
    _debounce.call(() {
      context.read<ArticlesSearchBloc>().onChangeText(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DismissKeyBoard(
        child: SafeArea(
          child: Column(
            children: [
              _renderAppBar(context),
              _renderSearchFieldAndTag(),
              Expanded(
                  child: BlocBuilder<ArticlesSearchBloc, ArticlesSearchState>(
                      buildWhen: (pre, cur) =>
                          pre.listSearchedArticles != cur.listSearchedArticles,
                      builder: (context, state) {
                        if (state.listSearchedArticles == null) {
                          return const SizedBox.shrink();
                        }
                        if (state.listSearchedArticles!.isEmpty) {
                          return _renderSomethingWentWrong(
                              S.of(context).noArticlesFound);
                        }
                        return _renderArticles();
                      }))
            ],
          ),
        ),
      ),
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
    );
  }

  Column _renderSomethingWentWrong(String errorText) {
    return Column(
      children: [
        Assets.svg.emptyIllustratiom.svg(width: AppSize.s200),
        Text(errorText,
            style: AppTextStyle.titleTextStyle
                .copyWith(fontSize: AppFontSize.f16)),
      ],
    );
  }

  Widget _renderSearchFieldAndTag() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          XTextFieldWithLabel(
            hintText: S.of(context).enterArticlesName,
            hintStyle: AppTextStyle.hintTextStyle,
            suffix: const Icon(
              Icons.search,
              color: AppColors.primary,
            ),
            onChanged: (text) {
              _onChangeText(text);
            },
          ),
          BlocBuilder<ArticlesSearchBloc, ArticlesSearchState>(
              buildWhen: (pre, cur) =>
                  listEquals(pre.listSelectedTags, cur.listSelectedTags) ==
                      false ||
                  pre.isExpand != cur.isExpand ||
                  pre.status != cur.status ||
                  listEquals(pre.tags, cur.tags) == false,
              builder: (context, state) {
                return Wrap(
                  spacing: AppPadding.p6,
                  runSpacing: AppPadding.p6,
                  children: [
                    for (String tag in state.tags ?? [])
                      XWarningChip(
                        title: tag,
                        hasIcon: false,
                        border: state.listSelectedTags?.contains(tag) == true
                            ? Border.all(width: 1.5, color: AppColors.primary)
                            : Border.all(width: 0.5, color: AppColors.black),
                        bgColor: state.listSelectedTags?.contains(tag) == true
                            ? AppColors.subPrimary
                            : AppColors.white,
                        onTap: (tag) => context
                            .read<ArticlesSearchBloc>()
                            .setListSelectedTag(tag),
                      )
                  ],
                );
              })
        ],
      ),
    );
  }

  Widget _renderArticles() {
    return Expanded(
        child: BlocSelector<ArticlesSearchBloc, ArticlesSearchState,
            List<MArticles>?>(
      selector: (state) => state.listSearchedArticles,
      builder: (context, articles) {
        return isNullOrEmpty(articles) ||
                isNullOrEmpty(
                    context.read<ArticlesSearchBloc>().state.listSearchedImage)
            ? const SizedBox.shrink()
            : ListView.builder(
                itemCount: articles!.length,
                itemBuilder: (context, index) => _renderArticleCard(
                    context,
                    articles[index],
                    context
                        .read<ArticlesSearchBloc>()
                        .state
                        .listSearchedImage![articles[index].id]));
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
