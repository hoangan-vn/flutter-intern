import 'package:flutter/foundation.dart';
import 'package:safebump/src/network/data/video/video_reference.dart';
import 'package:safebump/src/network/data/video/video_repository.dart';
import 'package:safebump/src/network/data/video/video_storage_reference.dart';
import 'package:safebump/src/network/model/common/result.dart';
import 'package:safebump/src/network/model/video/video.dart';

class VideosRepositoryImpl extends VideosRepository {
  final videoRef = VideoReference();
  final videoStorageRef = VideoStorageReference();
  @override
  Future<MResult<List<MVideo>>> getAllVideos() async {
    return await videoRef.getAllVideos();
  }

  @override
  Future<MResult<List>> getAllVideosThumbnail() async {
    return await videoStorageRef.getAllVideoThumbnails();
  }

  @override
  Future<MResult<Uint8List>> getVideoThumbnail(String id) async {
    return await videoStorageRef.getVideoThumbnail(id);
  }

  @override
  Future<MResult<String>> getVideoUrl(String id) async {
    return await videoStorageRef.getVideo(id);
  }
}
