import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/firebase/base_collection.dart';
import 'package:safebump/src/network/firebase/collection/collection.dart';
import 'package:safebump/src/network/model/articles/articles.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/utils/utils.dart';

class ArticlesReference extends BaseCollectionReference<MArticles> {
  ArticlesReference()
      : super(
          XCollection.articles,
          getObjectId: (e) => e.id,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  Future<MResult<MArticles>> getOrAddArticles(MArticles article) async {
    try {
      final result = await get(article.id);
      if (result.isError == true) {
        return result;
      } else {
        final MResult<MArticles> result = await set(article);
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<MArticles>> getArticle(String id) async {
    try {
      final result = await get(id);
      if (result.isError == false) {
        return result;
      } else {
        return MResult.error(S.text.someThingWentWrong);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MArticles>>> getAllArticles() async {
    try {
      final QuerySnapshot<MArticles> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> deleteArticle(MArticles article) async {
    try {
      final result = await get(article.id);
      if (result.isError == false) {
        return MResult.success(false);
      } else {
        final MResult<bool> result = await delete(article);
        xLog.e(result.data);
        return MResult.success(true);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
