import 'package:flutter/material.dart';
import 'package:safebump/src/theme/colors.dart';
import 'package:safebump/src/theme/value.dart';
import 'package:video_player/video_player.dart';

class XPlayBackOption extends StatefulWidget {
  const XPlayBackOption({super.key, required this.controller});

  final VideoPlayerController controller;

  @override
  State<XPlayBackOption> createState() => _XPlayBackOptionState();
}

class _XPlayBackOptionState extends State<XPlayBackOption> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.addListener(() {
      if (_controller.value.isCompleted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        IconButton(
            onPressed: () {
              _controller
                  .setPlaybackSpeed(_controller.value.playbackSpeed - 0.5);
              setState(() {});
            },
            icon: const Icon(
              Icons.keyboard_double_arrow_left_rounded,
              size: AppSize.s36,
              color: AppColors.white,
            )),
        IconButton(
            onPressed: () {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
              setState(() {});
            },
            icon: Icon(
              _controller.value.isPlaying
                  ? Icons.pause_circle_outline_sharp
                  : Icons.play_circle_outline_sharp,
              size: AppSize.s36,
              color: AppColors.white,
            )),
        IconButton(
            onPressed: () {
              _controller
                  .setPlaybackSpeed(_controller.value.playbackSpeed + 0.5);
              setState(() {});
            },
            icon: const Icon(
              Icons.keyboard_double_arrow_right_rounded,
              size: AppSize.s36,
              color: AppColors.white,
            )),
      ],
    );
  }
}
