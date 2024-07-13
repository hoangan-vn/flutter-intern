import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safebump/src/dialogs/toast_wrapper.dart';
import 'package:safebump/src/feature/video/logic/video_state.dart';
import 'package:safebump/src/feature/video/widget/playback_option.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/data/video/video_repository.dart';
import 'package:safebump/src/network/model/video/video.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/utils.dart';
import 'package:video_player/video_player.dart';

class VideoBloc extends Cubit<VideoState> {
  VideoBloc() : super(VideoState());

  Future<void> inital(BuildContext context) async {
    _createLoadingScreen();
    await _getVideoDetailFromFirebase(context);
    _hideLoadingScreen();
  }

  void _createLoadingScreen() {
    emit(state.copyWith(status: VideoStatus.loading));
    XToast.showLoading();
  }

  void _hideLoadingScreen() {
    if (XToast.isShowLoading) {
      XToast.hideLoading();
    }
  }

  Future<void> _getVideoDetailFromFirebase(BuildContext context) async {
    try {
      final result = await GetIt.I.get<VideosRepository>().getAllVideos();
      if (result.data == null) {
        emit(state.copyWith(status: VideoStatus.fail));
        return;
      }
      emit(state.copyWith(videos: result.data));
      await _getListVideoThumbnails();
    } catch (e) {
      xLog.e(e);
      emit(state.copyWith(status: VideoStatus.fail));
    }
  }

  Future<void> _getListVideoThumbnails() async {
    Map<String, Uint8List> listImage = {};
    for (MVideo video in state.videos ?? []) {
      try {
        final image =
            await GetIt.I.get<VideosRepository>().getVideoThumbnail(video.id);
        if (image.data != null) {
          listImage.addEntries({video.id: image.data!}.entries);
        }
      } catch (e) {
        xLog.e(e);
      }
    }
    emit(state.copyWith(listThumbnail: listImage));
  }

  Future<String> getVideoUrl(String id) async {
    _createLoadingScreen();
    try {
      final result = await GetIt.I.get<VideosRepository>().getVideoUrl(id);
      _hideLoadingScreen();
      if (result.data != null) {
        return result.data!;
      }
      return '';
    } catch (e) {
      xLog.e(e);
      _hideLoadingScreen();
      XToast.error(S.text.someThingWentWrong);
      return '';
    }
  }

  void showFullVideo(BuildContext context, VideoPlayerController controller) {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => GestureDetector(
              onTap: () => AppCoordinator.pop(),
              child: Container(
                color: AppColors.black.withOpacity(0.5),
                padding: const EdgeInsets.all(AppPadding.p20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoPlayer(controller),
                    ),
                    XPlayBackOption(controller: controller)
                  ],
                ),
              ),
            )).then((value) => controller.dispose());
  }
}
