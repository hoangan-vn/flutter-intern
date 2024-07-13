// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/articles/logic/articles_state.dart';
import 'package:safebump/src/local/database_app.dart';
import 'package:safebump/src/local/repo/articles/article_local_repo.dart';
import 'package:safebump/src/network/data/articles/articles_repository.dart';
import 'package:safebump/src/network/model/articles/articles.dart';
import 'package:safebump/src/utils/utils.dart';

class ArticlesBloc extends Cubit<ArticlesState> {
  ArticlesBloc() : super(ArticlesState());

  Future<void> inital(BuildContext context) async {
    _createLoadingScreen();
    await _getArticles(context);
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

  Future<void> _getArticles(BuildContext context) async {
    try {
      final articles =
          await GetIt.I.get<ArticlesLocalRepo>().getAllDetails().get();
      if (articles.isEmpty) {
        await _getArticlesFromFirebase(context);
        return;
      }
      final listArticles = ArticlesExt.convertFromEntityData(articles);
      final listImages = ArticlesExt.getListImage(articles);
      emit(state.copyWith(articles: listArticles, listImage: listImages));
    } catch (e) {
      xLog.e(e);
      emit(state.copyWith(status: ArticlesStatus.fail));
      _hideLoadingScreen();
    }
  }

  Future<void> _getArticlesFromFirebase(BuildContext context) async {
    try {
      final result = await GetIt.I.get<ArticlesRepository>().getAllArticles();
      if (result.data == null) {
        emit(state.copyWith(status: ArticlesStatus.fail));
        _hideLoadingScreen();
        return;
      }
      emit(state.copyWith(articles: result.data));
      await _saveToLocalDatabase(result.data!);
      await _getListAticleImages();
      _hideLoadingScreen();
    } catch (e) {
      xLog.e(e);
      emit(state.copyWith(status: ArticlesStatus.fail));
      _hideLoadingScreen();
    }
  }

  Future<void> _getListAticleImages() async {
    Map<String, Uint8List> listImage = {};
    for (MArticles article in state.articles ?? []) {
      try {
        final image =
            await GetIt.I.get<ArticlesRepository>().getArticleImage(article.id);
        if (image.data != null) {
          listImage.addEntries({article.id: image.data!}.entries);
          GetIt.I.get<ArticlesLocalRepo>().upsert(ArticlesEntityData(
              id: article.id,
              title: article.title,
              content: article.content,
              summarize: article.summarize,
              image: ArticlesExt.getImageString(image.data!)));
        }
      } catch (e) {
        xLog.e(e);
      }
    }
    emit(state.copyWith(listImage: listImage));
  }

  Future<void> _saveToLocalDatabase(List<MArticles> data) async {
    final articlesEntityData = data.convertToEntityData();
    for (ArticlesEntityData data in articlesEntityData) {
      await GetIt.I.get<ArticlesLocalRepo>().upsert(data);
    }
  }
}
