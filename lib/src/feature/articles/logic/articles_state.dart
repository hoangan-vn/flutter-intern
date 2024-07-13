import 'package:flutter/foundation.dart';
import 'package:safebump/src/network/model/articles/articles.dart';

enum ArticlesStatus { init, loading, success, fail }

class ArticlesState {
  ArticlesState(
      {this.status = ArticlesStatus.init, this.articles, this.listImage});

  final ArticlesStatus status;
  final List<MArticles>? articles;
  final Map<String, Uint8List>? listImage;
  ArticlesState copyWith(
      {ArticlesStatus? status,
      List<MArticles>? articles,
      Map<String, Uint8List>? listImage}) {
    return ArticlesState(
        status: status ?? this.status,
        articles: articles ?? this.articles,
        listImage: listImage ?? this.listImage);
  }
}
