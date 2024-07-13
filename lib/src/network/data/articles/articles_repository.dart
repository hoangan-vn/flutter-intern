import 'dart:typed_data';

import 'package:safebump/src/network/model/articles/articles.dart';
import 'package:safebump/src/network/model/common/result.dart';

abstract class ArticlesRepository {
  Future<MResult<List<MArticles>>> getAllArticles();

  Future<MResult<MArticles>> getArticle(String id);

  Future<MResult<List>> getAllArticlesImage();

  Future<MResult<Uint8List>> getArticleImage(String id);
}
