import 'package:flutter/foundation.dart';
import 'package:safebump/src/network/model/video/video.dart';

enum VideoStatus { init, loading, success, fail }

class VideoState {
  VideoState(
      {this.status = VideoStatus.init, this.videos, this.listThumbnail});

  final VideoStatus status;
  final List<MVideo>? videos;
  final Map<String, Uint8List>? listThumbnail;
  VideoState copyWith(
      {VideoStatus? status,
      List<MVideo>? videos,
      Map<String, Uint8List>? listThumbnail}) {
    return VideoState(
        status: status ?? this.status,
        videos: videos ?? this.videos,
        listThumbnail: listThumbnail ?? this.listThumbnail);
  }
}
