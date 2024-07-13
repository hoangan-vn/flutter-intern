import 'dart:typed_data';

import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/video/video.dart';

abstract class VideosRepository {
  Future<MResult<List<MVideo>>> getAllVideos();

  Future<MResult<String>> getVideoUrl(String id);

  Future<MResult<List>> getAllVideosThumbnail();

  Future<MResult<Uint8List>> getVideoThumbnail(String id);
}
