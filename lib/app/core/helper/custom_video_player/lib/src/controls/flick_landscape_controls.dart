import 'package:fasttrackfitness/app/core/helper/custom_video_player/lib/flick_video_player.dart';
import 'package:flutter/material.dart';

/// Default landscape controls.
class FlickLandscapeControls extends StatelessWidget {
  const FlickLandscapeControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlickPortraitControls(
      fontSize: 14,
      iconSize: 30,
      progressBarSettings: FlickProgressBarSettings(
        height: 5,
      ),
    );
  }
}
