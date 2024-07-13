import 'package:flutter/foundation.dart';
import 'package:safebump/src/network/model/articles/articles.dart';

enum ArticleDetailStatus { init, loading, fail, success }

class ArticleDetailState {
  ArticleDetailState(
      {required this.id,
      this.status = ArticleDetailStatus.init,
      this.article,
      this.listRelateArticle,
      this.listRelateImage,
      this.image});

  final MArticles? article;
  final List<MArticles>? listRelateArticle;
  final Uint8List? image;
  final Map<String, Uint8List>? listRelateImage;
  final String id;
  final ArticleDetailStatus status;

  ArticleDetailState copyWith(
      {MArticles? article,
      List<MArticles>? listRelateArticle,
      Uint8List? image,
      Map<String, Uint8List>? listRelateImage,
      String? id,
      ArticleDetailStatus? status}) {
    return ArticleDetailState(
        article: article ?? this.article,
        image: image ?? this.image,
        listRelateArticle: listRelateArticle ?? this.listRelateArticle,
        listRelateImage: listRelateImage ?? this.listRelateImage,
        id: id ?? this.id,
        status: status ?? this.status);
  }
}
