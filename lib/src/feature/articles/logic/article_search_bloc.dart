import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/articles/logic/article_search_state.dart';
import 'package:safebump/src/local/repo/articles/article_local_repo.dart';
import 'package:safebump/src/network/model/articles/articles.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/src/utils/utils.dart';

class ArticlesSearchBloc extends Cubit<ArticlesSearchState> {
  ArticlesSearchBloc() : super(ArticlesSearchState());

  Future<void> inital(BuildContext context) async {
    _createLoadingScreen();
    await _getAllArticlesData(context);
    _getAllTags();
    _hideLoadingScreen();
  }

  void _createLoadingScreen() {
    emit(state.copyWith(status: ArticlesStatus.loading));
    XToast.showLoading();
  }

  void _hideLoadingScreen() {
    if (XToast.isShowLoading) {
      XToast.hideLoading();
    }
  }

  Future<void> _getAllArticlesData(BuildContext context) async {
    try {
      final articles =
          await GetIt.I.get<ArticlesLocalRepo>().getAllDetails().get();
      final listArticles = ArticlesExt.convertFromEntityData(articles);
      final listImages = ArticlesExt.getListImage(articles);
      emit(state.copyWith(articles: listArticles, listImage: listImages));
    } catch (e) {
      xLog.e(e);
      _hideLoadingScreen();
    }
  }

  void _getAllTags() async {
    List<String> listTags = [];
    for (MArticles article in state.articles ?? []) {
      listTags.addAll(article.tag);
    }
    emit(state.copyWith(
        tags: listTags.toSet().toList(),
        isExpand: !state.isExpand,
        status: state.status == ArticlesStatus.loading
            ? ArticlesStatus.init
            : ArticlesStatus.loading));
  }

  void onChangeText(String value) {
    emit(state.copyWith(searchText: value));
    _getSearchArticles();
  }

  void setListSelectedTag(String tag) {
    List<String> listSelectedTag = state.copyWith().listSelectedTags ?? [];
    if (listSelectedTag.contains(tag)) {
      emit(state.copyWith(
          listSelectedTags: listSelectedTag
              .where((element) => !element.contains(tag))
              .toList()));
    } else {
      emit(state.copyWith(
          listSelectedTags: listSelectedTag.followedBy([tag]).toList()));
    }
    _getSearchArticles();
  }

  void _getSearchArticles() {
    List<MArticles> listSearchArticles = [];
    Map<String, Uint8List> listSearchImages = {};
    for (MArticles article in state.articles ?? []) {
      bool isCheckWithTag = false;
      if (!StringUtils.isNullOrEmpty(state.searchText)) {
        if (article.title
            .toLowerCase()
            .contains(state.searchText!.toLowerCase())) {
          final isGetByTag = _isGetArticleByTag(article);
          if (isGetByTag != false) {
            listSearchArticles.add(article);
            listSearchImages.addEntries({
              article.id: (state.listImage ?? {})[article.id] ?? Uint8List(0)
            }.entries);
            isCheckWithTag = true;
          }
        }
      } else if (_isGetArticleByTag(article) == true && !isCheckWithTag) {
        listSearchArticles.add(article);
        listSearchImages.addEntries({
          article.id: (state.listImage ?? {})[article.id] ?? Uint8List(0)
        }.entries);
      }
    }
    emit(state.copyWith(
        listSearchedArticles: listSearchArticles,
        listSearchedImage: listSearchImages));
  }

  bool? _isGetArticleByTag(MArticles article) {
    if (!isNullOrEmpty(state.listSelectedTags)) {
      if (article.tag.indexWhere(
              (element) => state.listSelectedTags!.contains(element)) !=
          -1) {
        return true;
      }
      return false;
    }
    return null;
  }
}
