import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/firebase/base_collection.dart';
import 'package:safebump/src/network/firebase/collection/collection.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/user/user.dart';
import 'package:safebump/src/utils/utils.dart';

class UserReference extends BaseCollectionReference<MUser> {
  UserReference()
      : super(
          XCollection.user,
          getObjectId: (e) => e.id,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  Future<MResult<MUser>> getOrAddUser(MUser user) async {
    try {
      final result = await get(user.id);
      if (result.isError == false) {
        return result;
      } else {
        final MResult<MUser> result = await set(user);
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> updateUser(MUser user) async {
    try {
      final result = await update(user.id, user.toJson());
      if (result.isError == true) {
        return MResult.error(S.text.someThingWentWrong);
      } else {
        return MResult.success(true);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MUser>>> getUsers() async {
    try {
      final QuerySnapshot<MUser> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> deleteUser(MUser user) async {
    try {
      final result = await delete(user);
      if (result.isError == true) {
        return MResult.exception(false);
      }
      return result;
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }
}
