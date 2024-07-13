import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safebump/src/network/firebase/base_collection.dart';
import 'package:safebump/src/network/firebase/collection/collection.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/quiz/quiz.dart';

class QuizReference extends BaseCollectionReference<MQuiz> {
  QuizReference()
      : super(
          XCollection.quiz,
          getObjectId: (e) => e.id,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  Future<MResult<List<MQuiz>>> getAllQuiz() async {
    try {
      final QuerySnapshot<MQuiz> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
