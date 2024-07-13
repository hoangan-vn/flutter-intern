import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/articles/logic/article_detail_state.dart';
import 'package:safebump/src/local/repo/articles/article_local_repo.dart';
import 'package:safebump/src/network/model/articles/articles.dart';
import 'package:safebump/src/utils/utils.dart';

class ArticleDetailBloc extends Cubit<ArticleDetailState> {
  ArticleDetailBloc({required String id}) : super(ArticleDetailState(id: id));

  Future<void> inital(BuildContext context) async {
    _createLoadingScreen();
    await _getDetailArticle();
    _hideLoadingScreen();
  }

  void _createLoadingScreen() {
    emit(state.copyWith(status: ArticleDetailStatus.loading));
    XToast.showLoading();
  }

  void _hideLoadingScreen() {
    if (XToast.isShowLoading) {
      XToast.hideLoading();
    }
  }

  Future<void> _getDetailArticle() async {
    try {
      final result =
          await GetIt.I.get<ArticlesLocalRepo>().getDetail(id: state.id).get();
      final articleData = ArticlesExt.convertFromEntityData(result);
      final articleImage = ArticlesExt.getListImage(result);
      await _getListRelatedArticle(articleData.first.tag);
      emit(state.copyWith(
          article: articleData.first,
          image: articleImage[state.id],
          status: ArticleDetailStatus.success));
    } catch (e) {
      xLog.e(e);
    }
  }

  Future<void> _getListRelatedArticle(List<String> tag) async {
    try {
      final result =
          await GetIt.I.get<ArticlesLocalRepo>().getAllDetails().get();
      final articlesData = ArticlesExt.convertFromEntityData(result);
      final articlesImage = ArticlesExt.getListImage(result);
      List<MArticles> listRelatedArticles = [];
      Map<String, Uint8List> listRelatedImages = {};

      articlesData.removeWhere((element) => element.id == state.id);

      for (MArticles article in articlesData) {
        if (article.tag.indexWhere((element) => tag.contains(element)) != -1) {
          listRelatedArticles.add(article);
          listRelatedImages.addEntries(
              {article.id: articlesImage[article.id] ?? Uint8List(0)}.entries);
        }
      }
      emit(state.copyWith(
          listRelateArticle: listRelatedArticles,
          listRelateImage: listRelatedImages));
    } catch (e) {
      xLog.e(e);
    }
  }
}
