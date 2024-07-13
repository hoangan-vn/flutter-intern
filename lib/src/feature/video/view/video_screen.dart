// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safebump/src/feature/video/logic/video_bloc.dart';
import 'package:safebump/src/feature/video/logic/video_state.dart';
import 'package:safebump/src/localization/localization_utils.dart';
import 'package:safebump/src/network/model/video/video.dart';
import 'package:safebump/src/router/coordinator.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/decorations.dart';
import 'package:safebump/src/theme/styles.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:safebump/src/utils/padding_utils.dart';
import 'package:safebump/src/utils/string_utils.dart';
import 'package:safebump/src/utils/utils.dart';
import 'package:safebump/widget/appbar/appbar_dashboard.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    context.read<VideoBloc>().inital(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _renderAppBar(context),
          _renderListArticles(context),
        ],
      )),
    );
  }

  Widget _renderAppBar(BuildContext context) {
    return XAppBarDashboard(
      title: S.of(context).videos,
      leading: IconButton(
        onPressed: () {
          AppCoordinator.pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _renderListArticles(BuildContext context) {
    return Expanded(
        child: BlocBuilder<VideoBloc, VideoState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.videos != current.videos ||
          previous.listThumbnail != current.listThumbnail,
      builder: (context, state) {
        return isNullOrEmpty(state.videos) || isNullOrEmpty(state.listThumbnail)
            ? const SizedBox.shrink()
            : ListView.builder(
                itemCount: state.videos!.length,
                itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: AppMargin.m10, horizontal: AppMargin.m16),
                      child: _renderVideoCard(context, state.videos![index],
                          state.listThumbnail![state.videos![index].id]),
                    ));
      },
    ));
  }

  Widget _renderVideoCard(
      BuildContext context, MVideo mVideos, Uint8List? image) {
    return Material(
      child: InkWell(
        onTap: () async {
          final url = await context.read<VideoBloc>().getVideoUrl(mVideos.id);
          if (!StringUtils.isNullOrEmpty(url)) {
            _controller = VideoPlayerController.networkUrl(Uri.parse(url))
              ..initialize().then((_) {
                // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                setState(() {});
              });
            context.read<VideoBloc>().showFullVideo(context, _controller);
          }
        },
        child: Ink(
          padding: const EdgeInsets.all(AppPadding.p15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r10),
              color: AppColors.white,
              boxShadow: AppDecorations.shadow),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderImage(image),
              XPaddingUtils.verticalPadding(height: AppPadding.p15),
              _renderTitle(mVideos.title),
              XPaddingUtils.verticalPadding(height: AppPadding.p10),
              _renderSummary(mVideos.content),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderImage(Uint8List? image) {
    return image == null
        ? const SizedBox.shrink()
        : Stack(
            alignment: Alignment.center,
            children: [
              Image.memory(image),
              _renderBackground(),
              const Icon(
                Icons.play_circle,
                color: AppColors.white,
                size: AppSize.s48,
              )
            ],
          );
  }

  Widget _renderBackground() {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: AppColors.black.withOpacity(0.3),
      ),
    );
  }

  Widget _renderTitle(String title) {
    return Text(
      title,
      style: AppTextStyle.titleTextStyle,
    );
  }

  Widget _renderSummary(String summarize) {
    return Text(summarize, style: AppTextStyle.contentTexStyleBold);
  }
}
