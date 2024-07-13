import 'package:flutter/foundation.dart';
import 'package:safebump/src/network/data/articles/articles_reference.dart';
import 'package:safebump/src/network/data/articles/articles_repository.dart';
import 'package:safebump/src/network/data/articles/articles_storage_reference.dart';
import 'package:safebump/src/network/model/articles/articles.dart';
import 'package:safebump/src/network/model/common/result.dart';

class ArticlesRepositoryImpl extends ArticlesRepository {
  final articleRef = ArticlesReference();
  final articleStorageRef = ArticlesStorageReference();
  @override
  Future<MResult<List<MArticles>>> getAllArticles() async {
    return await articleRef.getAllArticles();
  }

  @override
  Future<MResult<List>> getAllArticlesImage() async {
    return await articleStorageRef.getAllArticlesImage();
  }

  @override
  Future<MResult<Uint8List>> getArticleImage(String id) async {
    return await articleStorageRef.getArticleImage(id);
  }

  @override
  Future<MResult<MArticles>> getArticle(String id) async {
    return await articleRef.getArticle(id);
  }
}
