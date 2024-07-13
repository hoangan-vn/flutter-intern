import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safebump/src/network/firebase/base_collection.dart';
import 'package:safebump/src/network/firebase/collection/collection.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/daily_quiz.dart/daily_quiz.dart';
import 'package:safebump/src/utils/utils.dart';

class DailyQuizReference extends BaseCollectionReference<DailyQuiz> {
  DailyQuizReference()
      : super(
          XCollection.dailyQuiz,
          getObjectId: (e) => e.id,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  Future<MResult<DailyQuiz>> getOrAddQuiz(DailyQuiz quiz) async {
    try {
      final result = await get(quiz.id);
      if (result.isError == true) {
        return result;
      } else {
        final MResult<DailyQuiz> result = await set(quiz);
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<DailyQuiz>>> getAllQuiz() async {
    try {
      final QuerySnapshot<DailyQuiz> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> deleteQuiz(DailyQuiz quiz) async {
    try {
      final result = await get(quiz.id);
      if (result.isError == false) {
        return MResult.success(false);
      } else {
        final MResult<bool> result = await delete(quiz);
        xLog.e(result.data);
        return MResult.success(true);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
