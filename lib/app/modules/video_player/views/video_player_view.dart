import 'package:fasttrackfitness/app/core/helper/custom_video_player/lib/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/video_player_controller.dart';

class VideoPlayerView extends GetView<VideoPlayersController> {
  const VideoPlayerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlickVideoPlayer(
        flickManager: controller.flickManager,
        flickVideoWithControls: const FlickVideoWithControls(
          controls: FlickPortraitControls(),
          videoFit: BoxFit.contain,
          playerLoadingFallback: Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
