import 'package:flutter/foundation.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/firebase/base_storage.dart';
import 'package:safebump/src/network/firebase/collection/storage_collection.dart';
import 'package:safebump/src/network/model/baby_infor/baby_infor.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/utils/utils.dart';

class BabyInforStorageReference extends BaseStorageReference<MBabyInfor> {
  BabyInforStorageReference() : super(XStorageCollection.babyInfor, null);

  Future<MResult<Uint8List>> getBabyInforImage(String id) async {
    try {
      final result = await get("$id.jpg");
      if (result.data == null) {
        return MResult.error(S.text.someThingWentWrong);
      } else {
        return MResult.success(result.data);
      }
    } catch (e) {
      xLog.e(e);
      return MResult.exception(e);
    }
  }

  Future<MResult<List>> getAllBabyInforImage() async {
    try {
      final result = await getAll();
      return MResult.success(result.data);
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
