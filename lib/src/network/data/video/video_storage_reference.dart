import 'package:flutter/foundation.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/firebase/base_storage.dart';
import 'package:safebump/src/network/firebase/collection/storage_collection.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/video/video.dart';
import 'package:safebump/src/utils/utils.dart';

class VideoStorageReference extends BaseStorageReference<MVideo> {
  VideoStorageReference()
      : super(XStorageCollection.video, XStorageCollection.videoThumbnail);

  Future<MResult<Uint8List>> getVideoThumbnail(String id) async {
    try {
      final result = await get("$id.jpg", isGetFromSubRef: true);
      if (result.isError == true) {
        return result;
      } else {
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<String>> getVideo(String id) async {
    try {
      final result = await getUrl("$id.mp4");
      if (result.data != null) {
        return result;
      } else {
        return MResult.error(S.text.someThingWentWrong);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List>> getAllVideoThumbnails() async {
    try {
      final result = await getAll(isGetFromSubRef: true);
      return MResult.success(result.data);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> deleteVideoThumbnail(String id) async {
    try {
      final result = await get("$id.jpg");
      if (result.isError == false) {
        return MResult.success(false);
      } else {
        final MResult<bool> result = await delete("$id.jpg");
        xLog.e(result.data);
        return MResult.success(true);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
