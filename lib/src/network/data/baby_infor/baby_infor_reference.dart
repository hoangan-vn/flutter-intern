import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/firebase/base_collection.dart';
import 'package:safebump/src/network/firebase/collection/collection.dart';
import 'package:safebump/src/network/model/baby_infor/baby_infor.dart';
import 'package:safebump/src/network/model/common/result.dart';

class BabyInforReference extends BaseCollectionReference<MBabyInfor> {
  BabyInforReference()
      : super(
          XCollection.babyInfor,
          getObjectId: (e) => e.id,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  Future<MResult<MBabyInfor>> getBabyInforById(String id) async {
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

  Future<MResult<List<MBabyInfor>>> getAllBabyInfor() async {
    try {
      final QuerySnapshot<MBabyInfor> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
