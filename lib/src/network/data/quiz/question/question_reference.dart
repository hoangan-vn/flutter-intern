import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safebump/src/network/firebase/base_collection.dart';
import 'package:safebump/src/network/firebase/collection/collection.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/quiz/question.dart';

class QuestionReference extends BaseCollectionReference<MQuestion> {
  QuestionReference()
      : super(
          XCollection.question,
          getObjectId: (e) => e.id,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  Future<MResult<List<MQuestion>>> getAllQuestions() async {
    try {
      final QuerySnapshot<MQuestion> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
