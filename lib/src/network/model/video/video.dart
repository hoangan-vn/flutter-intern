import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class MVideo with _$MVideo {
  const MVideo._();
  const factory MVideo({
    required String id,
    required String title,
    required String content,
  }) = _MVideo;

  factory MVideo.empty() {
    return const MVideo(
      id: '',
      title: '',
      content: '',
    );
  }

  factory MVideo.fromJson(Map<String, Object?> json) =>
      _$MVideoFromJson(json);
}
