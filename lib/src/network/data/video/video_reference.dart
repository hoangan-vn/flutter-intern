import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safebump/src/network/firebase/base_collection.dart';
import 'package:safebump/src/network/firebase/collection/collection.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/video/video.dart';
import 'package:safebump/src/utils/utils.dart';

class VideoReference extends BaseCollectionReference<MVideo> {
  VideoReference()
      : super(
          XCollection.video,
          getObjectId: (e) => e.id,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  Future<MResult<MVideo>> getOrAddVideo(MVideo video) async {
    try {
      final result = await get(video.id);
      if (result.isError == true) {
        return result;
      } else {
        final MResult<MVideo> result = await set(video);
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MVideo>>> getAllVideos() async {
    try {
      final QuerySnapshot<MVideo> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<bool>> deleteVideo(MVideo video) async {
    try {
      final result = await get(video.id);
      if (result.isError == false) {
        return MResult.success(false);
      } else {
        final MResult<bool> result = await delete(video);
        xLog.e(result.data);
        return MResult.success(true);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
